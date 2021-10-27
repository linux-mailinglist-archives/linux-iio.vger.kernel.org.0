Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8189243C4FC
	for <lists+linux-iio@lfdr.de>; Wed, 27 Oct 2021 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbhJ0I0E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 Oct 2021 04:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236550AbhJ0I0E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 Oct 2021 04:26:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E7C061570;
        Wed, 27 Oct 2021 01:23:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id z11so1460346plg.8;
        Wed, 27 Oct 2021 01:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=60fQ3QIoLbMQK4UySn4ytPuPRhQ0ls3M7Uz1iL88x0k=;
        b=nyWu0NC4Q5JnhFKmcgt0oU7IPJxnQIioAjUxC9jtVrDVkM8R4AkASdA788wJszCkcw
         U3TyxGN3k0ELWKnc6OUbom2w9hedWYdBAa3nl41uy9am1g7g/SNoaDwWO+s3V+gOk6dD
         sWz8+/TobrfN9afT42Bi8ZhBoFPdyUfQYSLv9+G7M7B/JdR9ZxE++TCPyXYa/F8Z0KF7
         S0f22+3f0StEh11MSn+4aMBTFJfI9SzUllRy9q0ncpaWXj2uqzwUKSNusTMsXMPNzEco
         xbRhmu5LSZYlBHk/fS0Rea00uS/wIHDLheXYsT0XwuAxJ1NschxJ1bJizYHg96b412kO
         uz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=60fQ3QIoLbMQK4UySn4ytPuPRhQ0ls3M7Uz1iL88x0k=;
        b=yNWhi8O/G2nyNgtRhpRRwhwJ+05SCWp0VTc+pbD5IKIaVk1DQ9ZbWJB9WsJKPP29Qn
         mXdhnAp+zrT/Nnrln8cxuBdudQa5mREPA/pRo8tUgXm+0ZAc+3SjGI/MA15Z30wFQG3K
         ym/a3y8PP4jshfIqezD0dpdyf6ze25g8oCBqwYQYZaDgaluU3fvayooX8DhYRN6R3oyr
         TZpfQN5Zs3u1+gYAsOAILr1cAcnlDHc2aK4zZB49+6nmUs6WJGCQySdWN+BG1UBBHZlh
         6hYLcjH7FUGoyCvSKcxnCea9Q+rSvB6mVyxdmmdiAoQsN0K5c7wcFQRCbH/VK6mUDlXO
         lszw==
X-Gm-Message-State: AOAM532Hk/UarjQlyp6bHr037WZIX9z0OzErLBmN+L3h1yxKJ5nf3You
        msEsJdxJamWZTd5AyZLeayZLykzcINw=
X-Google-Smtp-Source: ABdhPJzSifRHKu/pCm6lo3aO7aCIzVOBNr9NdsWDwqBkueMlQoMnQq0+Ca8rKVk1Q5C1lnnYg0/Alg==
X-Received: by 2002:a17:90b:4c4a:: with SMTP id np10mr4331168pjb.233.1635323018616;
        Wed, 27 Oct 2021 01:23:38 -0700 (PDT)
Received: from shinobu ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id f8sm3328437pjq.29.2021.10.27.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:23:38 -0700 (PDT)
Date:   Wed, 27 Oct 2021 17:23:33 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] counter/ti-eqep: add support for edge capture unit
Message-ID: <YXkMheVhVp9psPDD@shinobu>
References: <20211017013343.3385923-1-david@lechnology.com>
 <20211017013343.3385923-8-david@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cb2YFZHgEVk1ZeTb"
Content-Disposition: inline
In-Reply-To: <20211017013343.3385923-8-david@lechnology.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Cb2YFZHgEVk1ZeTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 16, 2021 at 08:33:42PM -0500, David Lechner wrote:
> This adds support for the Edge Capture Unit to the TI eQEP counter
> driver. This just adds the minimum required features to measure speed
> using the Unit Timer and the Edge Capture unit. Additional features can
> be added in the future if needed.
>=20
> This adds 4 new device-level attributes:
> - edge_capture_unit_prescaler: selects a prescalar for the Counter count
> 	coming into the Edge Capture Unit
> - edge_capture_unit_max_period: selects the max time period that can be
> 	measured by the Edge Capture Unit

What happens if a trigger occurs after the max period has elapsed; is
the latched period value invalid in that scenario?

> - edge_capture_unit_latched_period: gets the period that was measured
> 	when the event selected by the latch_mode attribute is triggered

Is this period value essentially the current latch count minus the
previous latch count?

> - edge_capture_unit_enable: enables or disables the Edge Capture Unit
>=20
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/counter/ti-eqep.c | 150 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index ef899655ad1d..fb1f4d0b4cde 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -116,6 +116,12 @@
>  #define QEPSTS_FIMF		BIT(1)
>  #define QEPSTS_PCEF		BIT(0)
> =20
> +#define QCAPCTL_CEN		BIT(15)
> +#define QCAPCTL_CCPS_SHIFT	4
> +#define QCAPCTL_CCPS		GENMASK(6, 4)
> +#define QCAPCTL_UPPS_SHIFT	0
> +#define QCAPCTL_UPPS		GENMASK(3, 0)
> +
>  /* EQEP Inputs */
>  enum {
>  	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
> @@ -479,6 +485,137 @@ static struct counter_count ti_eqep_counts[] =3D {
>  	},
>  };
> =20
> +static int ti_eqep_edge_capture_unit_enable_read(struct counter_device *=
counter,
> +						 u8 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qcapctl;
> +
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	*value =3D !!(qcapctl & QCAPCTL_CEN);
> +
> +	return 0;
> +}
> +
> +static int ti_eqep_edge_capture_unit_enable_write(struct counter_device =
*counter,
> +						  u8 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
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
> +ti_eqep_edge_capture_unit_latched_period_read(struct counter_device *cou=
nter,
> +					      u64 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qcprdlat, qcapctl;
> +	u8 ccps;
> +
> +	regmap_read(priv->regmap16, QCPRDLAT, &qcprdlat);
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	ccps =3D (qcapctl & QCAPCTL_CCPS) >> QCAPCTL_CCPS_SHIFT;
> +
> +	/* convert timer ticks to nanoseconds */
> +	*value =3D mul_u64_u32_div(qcprdlat << ccps, NSEC_PER_SEC, priv->sysclk=
out_rate);
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_max_period_read(struct counter_device *counter,
> +					  u64 *value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qcapctl;
> +	u8 ccps;
> +
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	ccps =3D (qcapctl & QCAPCTL_CCPS) >> QCAPCTL_CCPS_SHIFT;
> +
> +	/* convert timer ticks to nanoseconds */
> +	*value =3D mul_u64_u32_div(USHRT_MAX << ccps, NSEC_PER_SEC,
> +				 priv->sysclkout_rate);
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_max_period_write(struct counter_device *counte=
r,
> +					   u64 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 period;
> +	u8 ccps;
> +
> +	/* convert nanoseconds to timer ticks */
> +	period =3D value =3D mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_=
PER_SEC);
> +	if (period !=3D value)
> +		return -ERANGE;
> +
> +	/* find the smallest divider that will fit the requested period */
> +	for (ccps =3D 0; ccps <=3D 7; ccps++)
> +		if (USHRT_MAX << ccps >=3D period)
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
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +	u32 qcapctl;
> +
> +	regmap_read(priv->regmap16, QCAPCTL, &qcapctl);
> +	*value =3D (qcapctl & QCAPCTL_UPPS) >> QCAPCTL_UPPS_SHIFT;
> +
> +	return 0;
> +}
> +
> +static int
> +ti_eqep_edge_capture_unit_prescaler_write(struct counter_device *counter,
> +					  u32 value)
> +{
> +	struct ti_eqep_cnt *priv =3D counter->priv;
> +
> +	regmap_write_bits(priv->regmap16, QCAPCTL, QCAPCTL_UPPS,
> +			  value << QCAPCTL_UPPS_SHIFT);
> +
> +	return 0;
> +}
> +
> +static const char *const ti_eqep_edge_capture_unit_prescaler_values[] =
=3D {
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
> @@ -601,6 +738,19 @@ static int ti_eqep_unit_timer_enable_write(struct co=
unter_device *counter,
>  }
> =20
>  static struct counter_comp ti_eqep_device_ext[] =3D {
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

Would it make sense for these to be Count 0 extensions so that they're
alongside the "latched_count" extension; or do these extensions also
represent values related to "latched_time" for the unit timer?

William Breathitt Gray

>  	COUNTER_COMP_DEVICE_ENUM("latch_mode", ti_eqep_latch_mode_read,
>  				ti_eqep_latch_mode_write, ti_eqep_latch_modes),
>  	COUNTER_COMP_DEVICE_U64("unit_timer_time", ti_eqep_unit_timer_time_read,
> --=20
> 2.25.1
>=20

--Cb2YFZHgEVk1ZeTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmF5DIUACgkQhvpINdm7
VJL/hRAAlrSuy+NSIsFsPQUhr5lGrA+gw7dfLQ5pR1PxFJcfejuQU4Ap19TYWFsr
wM3rG6uC+Wn0PE4FBRRfYtWRRrfvQpm3srEe9NTtbo3+xL+sQsyCnZIGnvTKAa6q
66jbiFGvUjAqewmo+UBJoQTzMU6MWt6oTh7tfnhZMaAkxED3EUffIEPQIWpAGqBX
3DlpDpde663Ctq9K15BulJbcjmRN41hgH2MLObhyQq75iMC3hi9fppKuXOfBl+Nj
T8ilbj+e3kIYwodYBPV8ZBVw+96ZVPpVMGHoK0wFt3pTW76L/hggMy/B3/JQTF8H
+gcEvkC63OvuOApNSnklIQjds4FGTFCJONyTKZ5yjkeKs4RWzuGzWEMMqzON5IXC
pvjlhxBhI0BPM2nAsHobzdEyAtTmF9l5zcpSBRpQn3BtDtkBC9NTdWedRdWK3M6C
sAfgfsWUzqyvBnIILW3/byKqH+Oinjh+xDRgUQbBAI1TxEZFyKxSZhLIyp41Vces
b6WV0SYMysRr33yfuLbNumRYy/p3TSjO5hCGMvaElwsNxXbfVwr7s/6FIgX9eeDw
FlvvfMAb7uPDGF974SmCIGZGm0Y2N1UJZ0BlbHiw8cRysftkjPIM1tqr5E1sHi/W
B0KcUTm6T6UpqVAOICh68n3p7pnWL4p5970IH4zDjz02EWOKyhc=
=NwLH
-----END PGP SIGNATURE-----

--Cb2YFZHgEVk1ZeTb--
