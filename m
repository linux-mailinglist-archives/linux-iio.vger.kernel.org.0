Return-Path: <linux-iio+bounces-19994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814BAC6D8A
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 18:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A3A4E2C9F
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5E228C86A;
	Wed, 28 May 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob8KMb7s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F828C854;
	Wed, 28 May 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448597; cv=none; b=CHusmOkR7EGBZDrS2jfewd61Y9A7KU0FN95Ffv/xGZrqBIkGZZtJilcFNVtS2G/Xlh91B7uSArQth5LFJc5izhNn9k/xCAvIQhrlaMVdIo+vFznj7qQSOvTyQVu1c2Zv+TBrHY/5GnVyR6LlgVr8+pZ3SPwPFN7lZyPzNHaEQwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448597; c=relaxed/simple;
	bh=4pIzHoj8Wd1R86ms192nvXS2WXmNPmnprRiEWCCPGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDprm9STEEBjtWEACuut1bAQ1IBYDbasLQUtZKyS2szeG1t8To7XKT0O0IYG2AcTjniBjriGgx8+//Z6fu6yScc4mHDywQrg9BMeeVBF42qBRZGX92EifxHTznNnh2TqvkulpIO1l/Z77VxPq4rNn/J/hX60eHmCgUDJFUMIV7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob8KMb7s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2349282084bso303095ad.1;
        Wed, 28 May 2025 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748448595; x=1749053395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ndd+6L/B1sq36+O8/FHu3Tozs8dSSyaGb710UgM7Sw=;
        b=Ob8KMb7sXw9qOww1CJ+j2EA3BohfJgH+6+eIzgJygYs8Us/xuZVykTg3l1qoiOk94Z
         kK69CrKS0dPGY4xLxuXuLNdHfWQ0b854d4qCo+bI6I7hSuvi3GfDwTVUIhq/YtDkvmm5
         ygGCsMuU4eTR9zOwScX7SbRNEyY0GnRIIcU9kcx3SbBXkCE95cLAaBJKdutNOaRn/v7b
         POxaohp2SJNd+ipVNGgq12RtBIbfZ0SQNtFuUdprB7a0Wx54o2TdnYfjXnquTlAQdydi
         m4r3AFGACrS5GPVR+blIvfPKHZyAmjUPI8uJcYOj6MrF1CuAbemtXbmskKrGPMjrZhmh
         DiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448595; x=1749053395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ndd+6L/B1sq36+O8/FHu3Tozs8dSSyaGb710UgM7Sw=;
        b=mCZTFt+KRgzPendUq2S+9dmQlPs8s+LB+Fau71547arXwu8zp0+ZO05yh/1jjoJy7a
         EQWkpEjhQL8/To/6V5zDRNysJUiJc1mcOCe5wqOVObuEkScWPtCrQfzg4jC87OHa0rws
         H8cEk3KFi6wX8bMpoRdtenoV2ObTrUNRHKd0sdvT8O7bYAXPUeMQIVWejbjjygKBkPVp
         49kyJ06LkIHBSRS9pNAf0/6FAJ/ZRb8p/pmx/unw+29yLdF8Lvsl3BcVsqY/QiiiA3Jj
         dvnx7UpqGKkYiU+R6jraxDDADTfwT9szhJwXKS9q5lfaDYzH6zy2OaKvefLyTs+tanDT
         TheQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5YC3IgSQNFTFJa89ACBYMYvD1WBJkYwxTDbQ+is/q1NdrRM5flVaj2t8CZFZeZLY57i+a1rx3VEHDyadm+46lnbo=@vger.kernel.org, AJvYcCWPdzGd5Dkb+5YEx600LeUQra2Ze/Fr6S/8qDrrjfP93b8FurWeE9ow40CxGEvCbTM4Ocfs4vriwOQ=@vger.kernel.org, AJvYcCWfphGpcIlN7PPSZFGEZGMGab9uFGF+OfvbkPEWfkzMK+AOTOpwTt6tmoK7ZK6lJf5CmA4ro54tGbjJjLtp@vger.kernel.org, AJvYcCX/kmw5uCT9wJnRNbk77b/ljR+B/Dlt2mbys26QoD+pWkZgC/+lDXHorSgYACj6vPI0tYYHF2X59xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLxIbHYRuvqJZedLzUXuWYkZrv2YKhUiqcLsymzh0TS6BUcso2
	p2LKCWgz7RhQAq5VysvFHlPi8Cs8v/wtMlrccjutWYRVbaHJTeC9sfJ4
X-Gm-Gg: ASbGncslFdsCJMFGXd6GbrebIqOjKBYs1I8Y2Ou9pN9Tpd+dDHBfzSlTtHf/31NIDDd
	LdYBAUlD06rR4sGkWiooXQQOjdbYhND1i8rhIG5NFMXurba2TAJCzezIc9VpxsENQb2mugpqz0m
	dqLjlaU6GqSJ1unW0fRkHQKqaGXghglUyrxtWAXvDKdE0vcK8dsAjz72TJa9ZH0r1eDTnIEKbII
	3P+jRQ7LGC1JHOcTA1jkpHVtAEd+F2eSNSUUjSg7dfVZRiMdpb4qJLX3SXX+BxBCc0Fk6kWcjqL
	XgXfmXPjnJys+J7g3DXe4yzTrW+R5QwQVJi10DpwuJ24Z67fa8ef
X-Google-Smtp-Source: AGHT+IEct1Mu/j97rbbxjLzBpmVysIk9gdkVmOYKtsSlG+RsTHJF3YcX0aRp3FdZFqor4oEVwjdt3g==
X-Received: by 2002:a17:903:4b0d:b0:234:a139:1208 with SMTP id d9443c01a7336-234a139160dmr96789515ad.16.1748448594950;
        Wed, 28 May 2025 09:09:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:a04a:d85e:c794:147c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35acbdasm13535885ad.197.2025.05.28.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 09:09:54 -0700 (PDT)
Date: Wed, 28 May 2025 09:09:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	jic23@kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	bhelgaas@google.com, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <rmc7me6rvumr6pcekgp5lsrxtuge5houitn474lkljew2hzdcw@z7wh2vtntvs5>
References: <20250526122054.65532-1-claudiu.beznea.uj@bp.renesas.com>
 <20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com>
 <hojdkntm3q5a5ywya7n5i4zy24auko4u6zdqm25infhd44nyfx@x2evb6sc2d45>
 <111d2d6c-8ac0-40b9-94c3-02f2f64ef9fe@tuxon.dev>
 <CAPDyKFoQYTNBhtBXY-Ds7E0TohtA6558W1Jf3cLsnXDQC74DSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoQYTNBhtBXY-Ds7E0TohtA6558W1Jf3cLsnXDQC74DSg@mail.gmail.com>

On Wed, May 28, 2025 at 06:04:45PM +0200, Ulf Hansson wrote:
> [...]
> 
> > >> +/**
> > >> + * devm_pm_domain_attach - devres-enabled version of dev_pm_domain_attach()
> > >> + * @dev: Device to attach.
> > >> + * @attach_power_on: Use to indicate whether we should power on the device
> > >> + *                   when attaching (true indicates the device is powered on
> > >> + *                   when attaching).
> > >> + * @detach_power_off: Used to indicate whether we should power off the device
> > >> + *                    when detaching (true indicates the device is powered off
> > >> + *                    when detaching).
> > >> + *
> > >> + * NOTE: this will also handle calling dev_pm_domain_detach() for
> > >> + * you during remove phase.
> > >> + *
> > >> + * Returns 0 on successfully attached PM domain, or a negative error code in
> > >> + * case of a failure.
> > >> + */
> > >> +int devm_pm_domain_attach(struct device *dev, bool attach_power_on,
> > >> +                      bool detach_power_off)
> > >
> > > Do we have examples where we power on a device and leave it powered on
> > > (or do not power on device on attach but power off it on detach)? I
> >
> > I haven't found one yet.
> >
> > > believe devm release should strictly mirror the acquisition, so separate
> > > flag is not needed.
> >
> > I was in the middle whether I should do it with 2 flags or only to revert
> > the acquisition.
> >
> > >
> > >
> > >> +{
> > >> +    int ret;
> > >> +
> > >> +    ret = dev_pm_domain_attach(dev, attach_power_on);
> > >> +    if (ret)
> > >> +            return ret;
> > >> +
> > >> +    if (detach_power_off)
> > >> +            return devm_add_action_or_reset(dev, devm_pm_domain_detach_off,
> > >> +                                            dev);
> > >> +
> > >> +    return devm_add_action_or_reset(dev, devm_pm_domain_detach_on, dev);
> > >
> > > Instead of 2 separate cleanup methods maybe define dedicated devres:
> > >
> > > struct dev_pm_domain_devres {
> > >       struct device *dev;
> > >       bool power_off;
> > > }
> > >
> > > ?
> >
> > That was the other option I've thought about but I found the one with 2
> > cleanup methods to be simpler. What would you prefer here?
> >
> > Ulf: could you please let me know what would you prefer here?
> 
> As it looks like we agreed to use one cleanup method, the struct
> dev_pm_domain_devres seems superfluous to me.

I think we agreed that cleanup should mirror the acquisition, that is
true. But since attaching to the domain has an option to either turn the
device on or not we still need 2 cleanup branches. They can either be
implemented with 2 cleanup callbacks or with 1 callback and dedicated
devres structure.

Thanks.

-- 
Dmitry

