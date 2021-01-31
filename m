Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59813309AF7
	for <lists+linux-iio@lfdr.de>; Sun, 31 Jan 2021 08:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhAaHg3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Jan 2021 02:36:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:19103 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhAaHgB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Jan 2021 02:36:01 -0500
IronPort-SDR: 4ZCABrrSHiC7qEBakMDnusBCgRw7EAE10ew/xVUivWWQAw/Ir3HtPXMAAM+i9a8of5GCm4lfCd
 sGOqw8PB1jyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9880"; a="199447121"
X-IronPort-AV: E=Sophos;i="5.79,389,1602572400"; 
   d="scan'208";a="199447121"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 23:34:13 -0800
IronPort-SDR: GqTSwjFIpJ/K+Lt8X27D3FV7tcvmIs2g1tB/l22/4wyfxMD3ND6RQwQj//6DihZvYjnnDEsdYW
 KdRRnd4GhZQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,389,1602572400"; 
   d="scan'208";a="371148858"
Received: from host.sh.intel.com (HELO host) ([10.239.154.115])
  by orsmga002.jf.intel.com with ESMTP; 30 Jan 2021 23:34:11 -0800
Date:   Sun, 31 Jan 2021 15:35:14 +0800
From:   "Ye, Xiang" <xiang.ye@intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensor-prox: Fix scale not correct issue
Message-ID: <20210131073514.GA16368@host>
References: <20210130102530.31064-1-xiang.ye@intel.com>
 <20210130191429.2c485212@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130191429.2c485212@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jan 30, 2021 at 07:14:29PM +0000, Jonathan Cameron wrote:
> On Sat, 30 Jan 2021 18:25:30 +0800
> Ye Xiang <xiang.ye@intel.com> wrote:
> 
> > Currently, the proxy sensor scale is zero because it just return the
> > exponent directly. To fix this issue, this patch use
> > hid_sensor_format_scale to process the scale first then return the
> > output.
> > 
> > Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
> > Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> 
> Hi Ye Xiang,
> 
> There was a bit of fuzz on this so please take a look at
> my fixes-togreg branch and check it went in cleanly.
Have checked fixes-toreg branch, the patch it's correct.

Thanks
Ye Xiang

> 
> 
> > ---
> > v2:
> >   - Add Fixes tag
> > 
> > ---
> >  drivers/iio/light/hid-sensor-prox.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> > index 4ab285a418d5..4abcfe48f1d4 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -23,6 +23,9 @@ struct prox_state {
> >  	struct hid_sensor_common common_attributes;
> >  	struct hid_sensor_hub_attribute_info prox_attr;
> >  	u32 human_presence;
> > +	int scale_pre_decml;
> > +	int scale_post_decml;
> > +	int scale_precision;
> >  };
> >  
> >  static const u32 prox_sensitivity_addresses[] = {
> > @@ -98,8 +101,9 @@ static int prox_read_raw(struct iio_dev *indio_dev,
> >  		ret_type = IIO_VAL_INT;
> >  		break;
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = prox_state->prox_attr.units;
> > -		ret_type = IIO_VAL_INT;
> > +		*val = prox_state->scale_pre_decml;
> > +		*val2 = prox_state->scale_post_decml;
> > +		ret_type = prox_state->scale_precision;
> >  		break;
> >  	case IIO_CHAN_INFO_OFFSET:
> >  		*val = hid_sensor_convert_exponent(
> > @@ -221,6 +225,11 @@ static int prox_parse_report(struct platform_device *pdev,
> >  	dev_dbg(&pdev->dev, "prox %x:%x\n", st->prox_attr.index,
> >  			st->prox_attr.report_id);
> >  
> > +	st->scale_precision = hid_sensor_format_scale(
> > +				hsdev->usage,
> > +				&st->prox_attr,
> > +				&st->scale_pre_decml, &st->scale_post_decml);
> > +
> >  	return ret;
> >  }
> >  
> 
