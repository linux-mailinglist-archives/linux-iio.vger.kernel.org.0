Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E7F3288D3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Mar 2021 18:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhCARpO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Mar 2021 12:45:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:11250 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238307AbhCARll (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Mar 2021 12:41:41 -0500
IronPort-SDR: m027y/G/cmgD9jA5mJ8R16FE3c5vPJuZJEnS/ZCTZ72Tct3kkgtQdhb2PO4zHKnthN2wJzZz+x
 NU8HuCFcglIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="165779912"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="165779912"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 09:39:55 -0800
IronPort-SDR: WfJVKBudAbHcrsop2n5GL3NKGOXTewLJFqebUR4scZmcCp4/xUu/RPlzFBtFKVtPdnakDbqtok
 nEdrZ8uYag9Q==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="444374574"
Received: from jvarg12x-mobl.amr.corp.intel.com ([10.212.213.38])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 09:39:54 -0800
Message-ID: <c6e98531b4f209aad6b655091ff5e9ddd305515f.camel@linux.intel.com>
Subject: Re: [PATCH 2/5] iio: hid-sensor-als: Support change sensitivity in
 illuminance too.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ronald =?ISO-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Date:   Mon, 01 Mar 2021 09:39:54 -0800
In-Reply-To: <20210228144525.00000730@Huawei.com>
References: <20210228012643.69944-1-ronald@innovation.ch>
         <20210228012643.69944-3-ronald@innovation.ch>
         <20210228144525.00000730@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2021-02-28 at 14:45 +0000, Jonathan Cameron wrote:
> On Sat, 27 Feb 2021 17:26:40 -0800
> Ronald Tschalär <ronald@innovation.ch> wrote:
> 
> > Recent MacBook Pro's specify the usage of the change sensitivity
> > field
> > as illuminance (with a change sensitivity modifier) rather than as
> > light.
> > 
> > Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> This looks fine to me though it the hid sensors spec never fails to
> surprise
> me in the different slight variants of the same thing that come up.
> 
> Illuminance is at least fairly well defined, but who knows what for
> the DATA_LIGHT
> version takes?

The current implementations are deploying using
"HID_USAGE_SENSOR_LIGHT_ILLUM" usage id 0xD1 for input. So this is
natural to use the same usage id for sensitivity. So patch looks good
to me.

But most implementation choose to use DATA_LIGHT for the sensitivity.
probably referring to change in quantity of light without referring to
area. There are no obvious units specified for DATA_LIGHT in the spec.

Thanks,
Srinivas

> 
> Anyhow, lets give time for Srinivas to sanity check this as he's much
> more familiar
> with that spec than I am.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/light/hid-sensor-als.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/iio/light/hid-sensor-als.c
> > b/drivers/iio/light/hid-sensor-als.c
> > index a21c827e4953d..849ee37dcd866 100644
> > --- a/drivers/iio/light/hid-sensor-als.c
> > +++ b/drivers/iio/light/hid-sensor-als.c
> > @@ -252,6 +252,14 @@ static int als_parse_report(struct
> > platform_device *pdev,
> >  			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_AB
> > S |
> >  			HID_USAGE_SENSOR_DATA_LIGHT,
> >  			&st->common_attributes.sensitivity);
> > +
> > +		if (st->common_attributes.sensitivity.index < 0)
> > +			sensor_hub_input_get_attribute_info(hsdev,
> > +				HID_FEATURE_REPORT, usage_id,
> > +				HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSIT
> > IVITY_ABS |
> > +				HID_USAGE_SENSOR_LIGHT_ILLUM,
> > +				&st->common_attributes.sensitivity);
> > +
> >  		dev_dbg(&pdev->dev, "Sensitivity index:report %d:%d\n",
> >  			st->common_attributes.sensitivity.index,
> >  			st->common_attributes.sensitivity.report_id);

