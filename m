Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C74B3272A2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Feb 2021 15:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhB1OrS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 28 Feb 2021 09:47:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2612 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhB1OrR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Feb 2021 09:47:17 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DpQxy2lx4z67m8h;
        Sun, 28 Feb 2021 22:39:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 28 Feb 2021 15:46:34 +0100
Received: from localhost (10.47.88.221) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Sun, 28 Feb
 2021 14:46:33 +0000
Date:   Sun, 28 Feb 2021 14:45:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: hid-sensor-als: Support change sensitivity in
 illuminance too.
Message-ID: <20210228144525.00000730@Huawei.com>
In-Reply-To: <20210228012643.69944-3-ronald@innovation.ch>
References: <20210228012643.69944-1-ronald@innovation.ch>
        <20210228012643.69944-3-ronald@innovation.ch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.88.221]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Feb 2021 17:26:40 -0800
Ronald Tschalär <ronald@innovation.ch> wrote:

> Recent MacBook Pro's specify the usage of the change sensitivity field
> as illuminance (with a change sensitivity modifier) rather than as
> light.
> 
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
This looks fine to me though it the hid sensors spec never fails to surprise
me in the different slight variants of the same thing that come up.

Illuminance is at least fairly well defined, but who knows what for the DATA_LIGHT
version takes?

Anyhow, lets give time for Srinivas to sanity check this as he's much more familiar
with that spec than I am.

Jonathan

> ---
>  drivers/iio/light/hid-sensor-als.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index a21c827e4953d..849ee37dcd866 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -252,6 +252,14 @@ static int als_parse_report(struct platform_device *pdev,
>  			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
>  			HID_USAGE_SENSOR_DATA_LIGHT,
>  			&st->common_attributes.sensitivity);
> +
> +		if (st->common_attributes.sensitivity.index < 0)
> +			sensor_hub_input_get_attribute_info(hsdev,
> +				HID_FEATURE_REPORT, usage_id,
> +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +				HID_USAGE_SENSOR_LIGHT_ILLUM,
> +				&st->common_attributes.sensitivity);
> +
>  		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);

