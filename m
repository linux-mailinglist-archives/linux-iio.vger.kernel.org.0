Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7F430858
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245484AbhJQL1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:27:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241948AbhJQL1E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:27:04 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0799761248;
        Sun, 17 Oct 2021 11:24:52 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:29:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] counter/ti-eqep: add support for edge capture unit
Message-ID: <20211017122906.5aab6151@jic23-huawei>
In-Reply-To: <20211017013343.3385923-8-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-8-david@lechnology.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 20:33:42 -0500
David Lechner <david@lechnology.com> wrote:

> This adds support for the Edge Capture Unit to the TI eQEP counter
> driver. This just adds the minimum required features to measure speed
> using the Unit Timer and the Edge Capture unit. Additional features can
> be added in the future if needed.
> 
> This adds 4 new device-level attributes:
> - edge_capture_unit_prescaler: selects a prescalar for the Counter count
> 	coming into the Edge Capture Unit
> - edge_capture_unit_max_period: selects the max time period that can be
> 	measured by the Edge Capture Unit
> - edge_capture_unit_latched_period: gets the period that was measured
> 	when the event selected by the latch_mode attribute is triggered
> - edge_capture_unit_enable: enables or disables the Edge Capture Unit
> 
> Signed-off-by: David Lechner <david@lechnology.com>

A general comment on using FIELD_GET and FIELD_PREP to avoid having to
define shifts twice.


> ---
>  drivers/counter/ti-eqep.c | 150 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index ef899655ad1d..fb1f4d0b4cde 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -116,6 +116,12 @@
>  #define QEPSTS_FIMF		BIT(1)
>  #define QEPSTS_PCEF		BIT(0)
>  
> +#define QCAPCTL_CEN		BIT(15)
> +#define QCAPCTL_CCPS_SHIFT	4

As mentioned below, using FIELD_GET() etc can avoid need to separately
define the shifts.

> +#define QCAPCTL_CCPS		GENMASK(6, 4)
> +#define QCAPCTL_UPPS_SHIFT	0
> +#define QCAPCTL_UPPS		GENMASK(3, 0)
> +
>  /* EQEP Inputs */
>  enum {
>  	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
> @@ -479,6 +485,137 @@ static struct counter_count ti_eqep_counts[] = {
>  	},
>  };
>  
> +static int ti_eqep_edge_capture_unit_enable_read(struct counter_device *counter,
> +						 u8 *value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qcapctl;
> +
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	*value = !!(qcapctl & QCAPCTL_CEN);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_edge_capture_unit_enable_write(struct counter_device *counter,
> +						  u8 value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +
> +	if (value)
> +		regmap_set_bits(priv->regmap16, QCAPCTL, QCAPCTL_CEN);
> +	else
> +		regmap_clear_bits(priv->regmap16, QCAPCTL, QCAPCTL_CEN);
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_latched_period_read(struct counter_device *counter,
> +					      u64 *value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qcprdlat, qcapctl;
> +	u8 ccps;
> +
> +	regmap_read(priv->regmap16, QCPRDLAT, &qcprdlat);
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	ccps = (qcapctl & QCAPCTL_CCPS) >> QCAPCTL_CCPS_SHIFT;

FIELD_PREP / FIELD_GET and friends allow this sort of action to be expressed using
just one define of the mask rather than a mask and shift.

> +
> +	/* convert timer ticks to nanoseconds */
> +	*value = mul_u64_u32_div(qcprdlat << ccps, NSEC_PER_SEC, priv->sysclkout_rate);
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_max_period_read(struct counter_device *counter,
> +					  u64 *value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qcapctl;
> +	u8 ccps;
> +
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	ccps = (qcapctl & QCAPCTL_CCPS) >> QCAPCTL_CCPS_SHIFT;
> +
> +	/* convert timer ticks to nanoseconds */
> +	*value = mul_u64_u32_div(USHRT_MAX << ccps, NSEC_PER_SEC,
> +				 priv->sysclkout_rate);
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_max_period_write(struct counter_device *counter,
> +					   u64 value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 period;
> +	u8 ccps;
> +
> +	/* convert nanoseconds to timer ticks */
> +	period = value = mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_PER_SEC);
> +	if (period != value)
> +		return -ERANGE;
> +
> +	/* find the smallest divider that will fit the requested period */
> +	for (ccps = 0; ccps <= 7; ccps++)
> +		if (USHRT_MAX << ccps >= period)
> +			break;
> +
> +	if (ccps > 7)
> +		return -EINVAL;
> +
> +	regmap_write_bits(priv->regmap16, QCAPCTL, QCAPCTL_CCPS,
> +			  ccps << QCAPCTL_CCPS_SHIFT);
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_prescaler_read(struct counter_device *counter,
> +					 u32 *value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +	u32 qcapctl;
> +
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	*value = (qcapctl & QCAPCTL_UPPS) >> QCAPCTL_UPPS_SHIFT;
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_prescaler_write(struct counter_device *counter,
> +					  u32 value)
> +{
> +	struct ti_eqep_cnt *priv = counter->priv;
> +
> +	regmap_write_bits(priv->regmap16, QCAPCTL, QCAPCTL_UPPS,
> +			  value << QCAPCTL_UPPS_SHIFT);
> +
> +	return 0;
> +}
> +
> +static const char *const ti_eqep_edge_capture_unit_prescaler_values[] = {
> +	"1",
> +	"2",
> +	"4",
> +	"8",
> +	"16",
> +	"32",
> +	"64",
> +	"128",
> +	"256",
> +	"512",
> +	"1024",
> +	"2048",
> +};
> +
> +static DEFINE_COUNTER_ENUM(ti_eqep_edge_capture_unit_prescaler_available,
> +			   ti_eqep_edge_capture_unit_prescaler_values);
> +
>  static int ti_eqep_latch_mode_read(struct counter_device *counter,
>  					    u32 *value)
>  {
> @@ -601,6 +738,19 @@ static int ti_eqep_unit_timer_enable_write(struct counter_device *counter,
>  }
>  
>  static struct counter_comp ti_eqep_device_ext[] = {
> +	COUNTER_COMP_DEVICE_BOOL("edge_capture_unit_enable",
> +				 ti_eqep_edge_capture_unit_enable_read,
> +				 ti_eqep_edge_capture_unit_enable_write),
> +	COUNTER_COMP_DEVICE_U64("edge_capture_unit_latched_period",
> +				ti_eqep_edge_capture_unit_latched_period_read,
> +				NULL),
> +	COUNTER_COMP_DEVICE_U64("edge_capture_unit_max_period",
> +				ti_eqep_edge_capture_unit_max_period_read,
> +				ti_eqep_edge_capture_unit_max_period_write),
> +	COUNTER_COMP_DEVICE_ENUM("edge_capture_unit_prescaler",
> +				 ti_eqep_edge_capture_unit_prescaler_read,
> +				 ti_eqep_edge_capture_unit_prescaler_write,
> +				 ti_eqep_edge_capture_unit_prescaler_available),
>  	COUNTER_COMP_DEVICE_ENUM("latch_mode", ti_eqep_latch_mode_read,
>  				ti_eqep_latch_mode_write, ti_eqep_latch_modes),
>  	COUNTER_COMP_DEVICE_U64("unit_timer_time", ti_eqep_unit_timer_time_read,

