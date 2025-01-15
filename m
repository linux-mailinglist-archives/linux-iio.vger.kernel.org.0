Return-Path: <linux-iio+bounces-14369-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37056A1165D
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5125B1887C90
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035722E630;
	Wed, 15 Jan 2025 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TJd0Zfbc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BD1DA23
	for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736903445; cv=none; b=NJ5FI4lBN4k0ETgZVkf7ST8wLqKPgunM216n3e1fo45A/W+zMm9SfBaUoY9Fx3wK5g+gcMYPsbkJNWSyqx9ZFyXyxv9B1Y6LSL0dgmKbKQaEpPLNZsAi2Hjcd4jAkVEUgHpOhLJlWDJwpS/8kRnGiFuhFuVD06TfHbNWkG3e7q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736903445; c=relaxed/simple;
	bh=ry+hJVkI8+3UfkeVwBnOy9WPdx33LdzpZt+xNkJzgMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcI4ZYxm/axyjZLzt3xINqnACDF9gPXV/yF0ODCJZ6sLb06Uv5OER2VjwVIg6JXbonP/khsjj5XBPIH9R6h8g85S8fseTbG9URlI8qpUpH86U7Q+Xk6+Az5DUWh8wF3Dq6JdVvXjW5AljvCbiOPlxVvzmEPhye34LcjfeKyud8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TJd0Zfbc; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C02ED3F851
	for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736903435;
	bh=OyY8tttWt4acSLoDA2rMpc78s2898+qrLIFMqO/JCh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=TJd0Zfbcleurlh4+zkEnMQbJTEM5WSrFuXnet9emFOh9ZIG7Stxj64VRVmftKd82s
	 jnco2PkZeV8FPobFzCj2/uae1IfjrFTW485FBkgAkRuDvKFNZMiuQnFUSaBxRYBkHH
	 e0jAZkSdtlLAmYQXZwIIYgo1nwk+zEaJmi2sUCtsuHL7tj4pP4R/KuUwWOnnvmXDfH
	 IF8Wpus+wMqM59qssZgMtxTv9oKRa4J0uf4UjPd9HIL3gYiTSUFeuEF/1CUYxSvqe7
	 /POqa5b4viZkO/saV6hpzYPXQBHMMvJHYK+2r+460pHO99+tmE/05RU2w1cMcAeSk3
	 8P2waWsQSnJfA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef7fbd99a6so10670338a91.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 17:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736903433; x=1737508233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyY8tttWt4acSLoDA2rMpc78s2898+qrLIFMqO/JCh4=;
        b=QM0oYs46eK822nj7JIeeIXpAo9ry0Z5xN/TnbPOOApsRYxWar0LxQSGSTxDue5zLKs
         2sHA6SMTXyVJdLd+F49U63uEw/I5229aow7y+GL8/g37kUTjeVCG8fqGKFeyNNukV9sD
         0PREtm30n+P0LIZrPMwMC3NHfmvjSzddCgAwcDHQfDGT+pSb5ja01T7h90yCrA6PKMVK
         DgnuxuIb868MsFeKDLM5UiKC0/M6/z4RlOt3oNLLBfX57MqESz4l/VNkU75HXjy7VEPg
         NbyrVms5dWycd6lDpF1n8xyMKGRC4DDH1d5yB/ZRDMhXzh94h3gmbd9huB8z7FaJtWub
         NDsg==
X-Forwarded-Encrypted: i=1; AJvYcCX+L5ATDkoS9iZn4x1kA/9sJAnLwLo2YbmOTNHKKVza+eqvRmNFcOtOPDcMsRRn/8Yxpa0ws22e9Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkO4IhHr4Dxed0FW3KDTPbHLWzBwGg/7jLvpHhy1+78K008GkO
	uMheIYNfcGMdYxkD1C1Gnre1hJiMymagBij0+mw0CAzZi1RDy2/pZw6zsQahoLNXGI6FgfjGR7y
	o6GVri3ijzmlj8W1l+cET0sWcG8wNl0K9TTr8At+EnqFiFFPQfyq61JepNtT32eowJDtN2eKK8N
	S7I9xK0m5l
X-Gm-Gg: ASbGnctg0v+Fpu10pN1zwFHC/7jdTy+HBYqwmA7rbeooBBZfNqDBD/nrM0yPKbLGAXl
	lHRBVRNHb5DkwSERqOqR8JRkXMSHkaiZ9KXMgZPN18oszeJqaYV7Vg+HYxk3FkqifXfDro2HwWX
	t6cxKmysqvuSsZOJdhB5yiSs8R6ap0XeWoyxFUpBNLPGyBvZ+J4IDugpKcOgz927nwdaoc9ZkAB
	ceM5V+77KhM+TaKeFkohej4WmozkGc6e7usBX7Tyl0Fu9AYDqiyosbVB5Lp5OSBTlnyiUVY/ZJ8
	RCbuvx3FPT812Y0Nw5o3H9HlBAIu7jhsTPI=
X-Received: by 2002:a05:6a00:ac2:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72d21f7eba6mr35942696b3a.1.1736903432806;
        Tue, 14 Jan 2025 17:10:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3T7jY4Un/GVvHybJxTCkVjve+F5Y0teXAQHqW8ABRXQL/bE+TzgQkL46rPnKEjXOJqhEHmw==
X-Received: by 2002:a05:6a00:ac2:b0:725:ea30:ab15 with SMTP id d2e1a72fcca58-72d21f7eba6mr35942672b3a.1.1736903432464;
        Tue, 14 Jan 2025 17:10:32 -0800 (PST)
Received: from acelan-precision5470 (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067ef71sm8273881b3a.135.2025.01.14.17.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 17:10:31 -0800 (PST)
Date: Wed, 15 Jan 2025 09:10:25 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Peter Zijlstra <peterz@infradead.org>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] iio: hid-sensor-attributes: validate sensitivity
 attributes
Message-ID: <73lfadj2ss27z3p2u3cknvymnkdiuq5g775armqf4w25h6q372@bzlsbnakclqu>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Peter Zijlstra <peterz@infradead.org>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>
References: <20250114070227.1778298-1-acelan.kao@canonical.com>
 <75131fa5a35f8ffae23087aa19c8a8238f381d4d.camel@linux.intel.com>
 <9929d10e1d61f63e4fe461eea9efc42eb91fa44a.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9929d10e1d61f63e4fe461eea9efc42eb91fa44a.camel@linux.intel.com>

On Tue, Jan 14, 2025 at 09:12:54AM -0800, srinivas pandruvada wrote:
> On Tue, 2025-01-14 at 05:28 -0800, srinivas pandruvada wrote:
> > On Tue, 2025-01-14 at 15:02 +0800, Chia-Lin Kao (AceLan) wrote:
> > > An invalid sensor device was observed in HP 5MP Camera (USB ID
> > > 0408:5473)
> > > which provided valid index and report_ids for poll, report_state
> > > and
> > > power_state attributes, but had invalid report_latency,
> > > sensitivity,
> > > and
> > > timestamp attributes. This would cause the system to hang when
> > > using
> > > iio_info to access attributes, as runtime PM tried to wake up an
> > > unresponsive sensor.
> > > 
> > > Fix this by validating both sensitivity.index and
> > > sensitivity_rel.index
> > > during sensor probe. Since valid sensors must initialize these with
> > > non-negative values, reject the sensor if either index is negative.
> > > 
> > 
> > These are optional fields by spec. So we can't reject sensor. I worry
> > that this will cause more regressions.
> > 
> > We will need a blocked list. We don't process "Persistent Unique ID"
> > or
> > "Sensor Manufacturer/Model". Please check if the report descriptors
> > have any of these fields described in section 1.5 of spec.
> > 
> > > 
> We probably may not be able to read the above features, I suggest add
> this device Vendor=0408 ProdID=5473 
> hid_ignore_list[].
Yes, this works for me, too.
I'll go with this way and submit another patch later.

> 
> Thanks,
> Srinivas
> 
> 
> 
> > > [    2.594565] [453] hid-sensor-hub 0003:0408:5473.0003: Report
> > > latency attributes: ffffffff:ffffffff
> > > [    2.594573] [453] hid-sensor-hub 0003:0408:5473.0003: common
> > > attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff ffffffff:ffffffff
> > > [    2.595485] [453] hid-sensor-hub 0003:0408:5473.0003: Report
> > > latency attributes: ffffffff:ffffffff
> > > [    2.595492] [453] hid-sensor-hub 0003:0408:5473.0003: common
> > > attributes: 5:11, 3:11, 1:11 ffffffff:ffffffff ffffffff:ffffffff
> > > 
> > > T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> > > D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> > > P:  Vendor=0408 ProdID=5473 Rev=00.07
> > > S:  Manufacturer=Quanta
> > > S:  Product=HP 5MP Camera
> > > S:  SerialNumber=01.00.00
> > > C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
> > > I:  If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=01
> > > Driver=uvcvideo
> > > E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
> > > I:  If#= 1 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=01
> > > Driver=uvcvideo
> > > I:  If#= 2 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=01
> > > Driver=uvcvideo
> > > E:  Ad=85(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
> > > I:  If#= 3 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=01
> > > Driver=uvcvideo
> > > I:  If#= 4 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00
> > > Driver=usbhid
> > > E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=16ms
> > > I:  If#= 5 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01
> > > Driver=(none)
> > > 
> > > v2. add fixes tag and the device info
> > These change description goes below "---" line.
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > > Fixes: bba6d9e47f3e ("iio: hid-sensor-attributes: Fix sensor
> > > property
> > > setting failure.")
> > > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> > > ---
> > >  .../hid-sensors/hid-sensor-attributes.c       | 23 +++++++++++----
> > > --
> > > --
> > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > index ad1882f608c0..b7ffd97e6c56 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > @@ -564,8 +564,21 @@ int hid_sensor_parse_common_attributes(struct
> > > hid_sensor_hub_device *hsdev,
> > >  	} else
> > >  		st->timestamp_ns_scale = 1000000000;
> > >  
> > > +	ret = 0;
> > > +	if (st->sensitivity.index < 0 || st->sensitivity_rel.index
> > > <
> > > 0) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > >  	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
> > >  
> > > +	ret = sensor_hub_get_feature(hsdev,
> > > +				st->power_state.report_id,
> > > +				st->power_state.index,
> > > sizeof(value), &value);
> > > +	if (value < 0)
> > > +		ret = -EINVAL;
> > > +
> > > +out:
> > >  	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x,
> > > %x:%x
> > > %x:%x %x:%x\n",
> > >  		st->poll.index, st->poll.report_id,
> > >  		st->report_state.index, st-
> > > >report_state.report_id,
> > > @@ -573,15 +586,7 @@ int hid_sensor_parse_common_attributes(struct
> > > hid_sensor_hub_device *hsdev,
> > >  		st->sensitivity.index, st->sensitivity.report_id,
> > >  		timestamp.index, timestamp.report_id);
> > >  
> > > -	ret = sensor_hub_get_feature(hsdev,
> > > -				st->power_state.report_id,
> > > -				st->power_state.index,
> > > sizeof(value), &value);
> > > -	if (ret < 0)
> > > -		return ret;
> > > -	if (value < 0)
> > > -		return -EINVAL;
> > > -
> > > -	return 0;
> > > +	return ret;
> > >  }
> > >  EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
> > >  
> > 
> 

