Return-Path: <linux-iio+bounces-14258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914E7A0AEAC
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 06:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECF33A6DE7
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 05:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16D6230D07;
	Mon, 13 Jan 2025 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="P/d7f4Y5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F859B71
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736745408; cv=none; b=kNOFv7QgFCGT8anUclpovzKl40fGsjMyMHobPjM1A224bl+igrC4aPXu9iY31OU7oYKXWTnSB+ljjNcXykEALIRBjuWUU1RdfZUR35u1O+a07dGYK4QW/wHacjLXzoVPFWSz0PP0rOr22hrzb1pdGRyObaeMNbPS1RT0hEUX+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736745408; c=relaxed/simple;
	bh=YAaNoOeBb+oOd98u6wdlbm2JIMvGc5oI+2FwIY8gSbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPyPfBZjr4qPVHGeOdh3FPGpjfm1NFu4rjAuB9Zrb45yGRApHnoaRt1Ltii1RTw9cJi8sK3eQK7fSlygAsSatd1K25IvI8X4VAY4KiaW4E0vgJKGqWLpd3qvfFnhIScLPZq2+HelM/DzqJx/oHMHYrM9IuWiIncim/TNtgwWsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=P/d7f4Y5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1D8ED3F5B6
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 05:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736745402;
	bh=EpWadYLj4xvpsIsXw8bwMRdhg4AneUCdE8coSsqx0gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=P/d7f4Y5pY07+V+gJiWwzpQ5YHX7XDQ1IGE+cjJNp8tn9X5fGxO/z5rgptfbmf37L
	 pD2Glwaq9BWeWAeQFFUHTEqArBZfdCaoldoOf8U0w7slreuCaysaDpF01SuzpUTPec
	 wO1e800xRqCEwQJetPMlqtiGSZQ6xdmrTZG0j02BaRK79asrz+faevipttHiUbQq+f
	 oK4x1BJfzPnvVpPUB9JDSGAG5M6uG6M72dDkyDZDE4jN1729ZqfQfCYq4GaQoEYEyG
	 04G2Lflf7CLocom7cMyhpgkY8UCc0XhaWFCJnWGl8ErF4sFpNDmcCEikoUY1tyn8GK
	 b+nDWtOGJoDkw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21631cbf87dso73054355ad.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Jan 2025 21:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736745400; x=1737350200;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpWadYLj4xvpsIsXw8bwMRdhg4AneUCdE8coSsqx0gM=;
        b=qBgkQwGr2KHz8BiovHRVCQeTES2CWmJVyRdP3SgKeBYooId25LjfW1erz94VCDw/8u
         IN8EGeREwnVA1c/LZYZCO/KfyEYxXQaIvgY5c/H6aimIcJTs/1pu5aoDI+0xUT87TFPK
         UsnD+5b26+k91Zk0CmyCU457W3mAc/HjmxIoxC76XHwTEdUFtOWYjd3zF7WdGbSJdfe4
         RHPjf1Ygk1KM7XJd30Yl40XhGG5TBR2CBcI6/ukl0eB0kePMPrqKIVcxiOE260xeGkMD
         2COkEFHocvzsffa9rGvtrSHkSVQ898ndrseXb8cgl5BHY80IEJLjh5iJvZhAOAeYQsuu
         7/og==
X-Forwarded-Encrypted: i=1; AJvYcCVxtsnlMy0eIOzzIb8t7flOJ6qiY8bLNGtlFUqg4JnA+z1t2mJgLIqOXqtCh6Y+mmJqlsI6o8PYO1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeZhLqi24YRhvtLk+mQQUfGUeSxvaJQwvbh1mX+ftq5FVNq0z8
	j64D9QhEXImayOuMpAZPtIwLqp8h16XS2Avt3l7aMTYeiIGlXGd1t0yhA7RDjIrIMtwOidZ+c9m
	RW2ajgm/pY45D+g/h3cQK38AY6GFaDbkaK0U4bY8NgoJTqJ7gMVHC/bBSTSnA5jtfBCQ9xwvHdA
	==
X-Gm-Gg: ASbGncvh9JbDQDxWkmL/86XGKNPH9RvzR9xd2OZuGDjCNCm5+6K2vJT1Vn7nJah1XLj
	P7xwisNnBiwyac+p0PESosYZ/AtulmXlE9cjCYFwup6/KSTiGUAYB+coDtXp3YrTgZtYc5Rgm63
	O9+2NmOamvD8fdjNViw0if8KX03J+ev9za2MItQpSuhUyNwjRsTp5dDHcQ036cp9ZMYOynsv2Bp
	10qtWYI5W1atCJG9cM10Z27o0jca48BMXjQmNLcPVYuFHGHNfXCC8gFAGPynMarwTeBbsD+y4ie
	52NL1rtvpQRxiScdirR2Hq9ue9Sb2Uz07lk=
X-Received: by 2002:a05:6a20:394b:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1e88d1dba40mr30095885637.33.1736745400444;
        Sun, 12 Jan 2025 21:16:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7YRnQTeysd7wb6aRdWHT/fVp8unI5y9nMG7uvWFOl5Zv7T7BHODTleryfig9LoAGvFArHPQ==
X-Received: by 2002:a05:6a20:394b:b0:1e1:e2d9:307 with SMTP id adf61e73a8af0-1e88d1dba40mr30095862637.33.1736745400087;
        Sun, 12 Jan 2025 21:16:40 -0800 (PST)
Received: from acelan-precision5470 (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a9696sm5155622b3a.177.2025.01.12.21.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 21:16:39 -0800 (PST)
Date: Mon, 13 Jan 2025 13:16:33 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor-attributes: validate sensitivity
 attributes
Message-ID: <d2d43lc5zc3dff4uvbenr52ldjkumtupg3apvkeltb6xihh5rz@lh2ho5ablscc>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20250109040006.1273797-1-acelan.kao@canonical.com>
 <20250112145938.7138c922@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112145938.7138c922@jic23-huawei>

On Sun, Jan 12, 2025 at 02:59:38PM +0000, Jonathan Cameron wrote:
> On Thu,  9 Jan 2025 12:00:06 +0800
> "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com> wrote:
> 
> > An invalid sensor device was observed which provided valid index and
> > report_ids for poll, report_state and power_state attributes, but had
> > invalid report_latency, sensitivity, and timestamp attributes. This would
> > cause the system to hang when using iio_info to access attributes, as
> > runtime PM tried to wake up an unresponsive sensor.
> > 
> > [    2.594565] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
> > [    2.594573] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff ffffffff:ffffffff
> > [    2.595485] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
> > [    2.595492] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:11, 3:11, 1:11 ffffffff:ffffffff ffffffff:ffffffff
> > 
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> If you can come up with an appropriate fixes tag that would be great
> as will help us figure out how far this might be backported.
Sure, I'll add the following line in v2
Fixes: bba6d9e47f3e ("iio: hid-sensor-attributes: Fix sensor property setting failure.")

> 
> Also, can we add any info on what device this was seen on?
This invalid sensor is found on this USB camera[0408:5473]
I'll also add this to the v2 commit message.

T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0408 ProdID=5473 Rev=00.07
S:  Manufacturer=Quanta
S:  Product=HP 5MP Camera
S:  SerialNumber=01.00.00
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=01 Driver=uvcvideo
E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=01 Driver=uvcvideo
I:  If#= 2 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=01 Driver=uvcvideo
E:  Ad=85(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=01 Driver=uvcvideo
I:  If#= 4 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=16ms
I:  If#= 5 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

> +CC Jiri and Srinivas who are the other listed maintainers of this driver.
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  .../hid-sensors/hid-sensor-attributes.c       | 23 +++++++++++--------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index ad1882f608c0..b7ffd97e6c56 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -564,8 +564,21 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
> >  	} else
> >  		st->timestamp_ns_scale = 1000000000;
> >  
> > +	ret = 0;
> > +	if (st->sensitivity.index < 0 || st->sensitivity_rel.index < 0) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> >  	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
> >  
> > +	ret = sensor_hub_get_feature(hsdev,
> > +				st->power_state.report_id,
> > +				st->power_state.index, sizeof(value), &value);
> > +	if (value < 0)
> > +		ret = -EINVAL;
> > +
> > +out:
> >  	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
> >  		st->poll.index, st->poll.report_id,
> >  		st->report_state.index, st->report_state.report_id,
> > @@ -573,15 +586,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
> >  		st->sensitivity.index, st->sensitivity.report_id,
> >  		timestamp.index, timestamp.report_id);
> >  
> > -	ret = sensor_hub_get_feature(hsdev,
> > -				st->power_state.report_id,
> > -				st->power_state.index, sizeof(value), &value);
> > -	if (ret < 0)
> > -		return ret;
> > -	if (value < 0)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
> >  
> 

