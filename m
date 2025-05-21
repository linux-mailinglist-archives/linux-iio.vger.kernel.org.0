Return-Path: <linux-iio+bounces-19778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B7ABF8A3
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 17:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9072D7B1166
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E92220F36;
	Wed, 21 May 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICty0H/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1F220F2C;
	Wed, 21 May 2025 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839483; cv=none; b=RlGBONBd+u0iEly9utMCVS+iPoWP0V8BKJRPcCiwFL2o22IEmnZF4iBkSopiZqnWAX+y0TkSdWQLpy59uPRjKl62zDk8FE8sGq8yl7KWCFQM8oaKNZjrW2OhKLdDruX/HWFNYmq5PeF1eKX2bj7efw3D4qB1rlR0EntI3sRMr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839483; c=relaxed/simple;
	bh=8peql63m54JQWqCslhKHaeRwbMTCDuXV2I2szVdFOXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVpG6JbfU/PysRpgTRSa48jQZlGjfC9+NBSp1C25dG6Q3Spz2+voT8FbPgNmQ6/VzN3AcML2aRobmKFC248Ro5uHmKIdxTpKAMzSilK5BPruZw+7DKW2vhuE0XzDEo8wJhCgRJGg72b6C1hcbnM8pkOwBKdd1eQlHCqhx0Nx2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICty0H/v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-231f325366eso49994605ad.1;
        Wed, 21 May 2025 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747839481; x=1748444281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54EOY89xPKuu5RXd/TJKkivr+tlbwBDEPaRF+tL8qDQ=;
        b=ICty0H/vQz1PYxB4LMOARrPqjxir1N7jo51Np5DEVfnLO/B1nw++qpn9Mf7dS6J5uB
         cP9NF2cHiQthUr1zFBDTc+HYlLSxJyKUcrDAgauVEA6hQARwFz97+atlmmN9xa4LfM+U
         MiyH/WcYa25WZu4OLNw7sElKiGp9GxJ2936P/pOzX9c/QHQWiMOgLK/zCmUDorgefyGg
         //X9kJsH73jdxSGeDejo7rOvyc5RWXoOkMRe0HtvmHskJj1SDJywJi63G5l5u9V/TaYK
         /plIPApIKljSP5RsZq4o1cqVsJfIkev0MW0d3eTtpDSC50SKDxwGDdcBhhoLso90Y8eS
         4toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839481; x=1748444281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54EOY89xPKuu5RXd/TJKkivr+tlbwBDEPaRF+tL8qDQ=;
        b=iKpGktUdoph8UVdw7nGYspDLw6z4hTx39LhOjGvRC7Ld4dScERGhF4C5YGREoZrECv
         h/grEoA+jjKVHGl8Af2MFB5vJkBNtavul8iKbxh5aoLQS500jk7DmR+AJVAXLb8nEXg3
         dvJ9N3uznIk/JooFu4u2QK3kjhC2WlLRlQnNOOFEYgiL1RBIUTQ/lPIIztIhT664oXtl
         xvcvAQ4jqdClUhtB5nZ7i3/uwWokg+WpfU/5gXfP3NgqxYEheLY+O3GWnytuQh7/3wBA
         2ajaB1Dih7dmNMyLvtGFWWOXAr51Nyc0405gpT9PES/goxq9bVndPvhBibY8ckK+bxxK
         C1IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUSQnDR/4c5M9k7n4gPi5Q80YAtDvi978ik6x/5YmTWeFvWGCmEbqyf6/e4hSrhWJM60142rt/NnfVofINSqxzCjw=@vger.kernel.org, AJvYcCWya+3VgDwAinKVczkc9SoVXVrwL2qIGeGRJ7CYYlWlanrw6hqg337+Tl9c9RVkw+SnIvfQFf8LGUw=@vger.kernel.org, AJvYcCX2LT/uGIunb4schQwcG2EIkUYgzpz0bOmYRoOSoH2f2JwmwjMQH3dkxPaROUVBNjhj+sQrO1puVKG7FqEv@vger.kernel.org, AJvYcCXlH/ius1GXkgGo5tSKphRW+hlV4cTVLrvUMMXrz/5df09aTaftwkHxs/iR35qJsn2jzlIQqCbaazU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJasLkqQ9lXURA8swDgg2npQws0//MlqFyrjs5vedYf5N75pf8
	1jtXbIZDaWUk3tub4FqVetvncMRE3iIEfLQgChiEimYJ4sIwlbLkxE8s5ipLvg==
X-Gm-Gg: ASbGnctd3TxyvWhGAZEpzMmjtiJkjHZ9KIpH5CwiAMq7WSKHnLlD1kWlOIA6f7RzZUq
	sQUm3TBkDyB9qiqDWTM5L9gU+geP/AdJOkWnafR5juTglnHeRTxm7tmeCHdRNsnD6QX3pv33G0U
	auBXaNT9m27lRn0rER0khLEmQrXlbeF+hybSjwGSKdSBcD1ufygP5CiT+sGDERG7/7eIAp80veT
	Eoz6YFPQXComKSTONS8YI1XB4xV7QuNFm9zpadtN8hY1LnJv6rJUECpyxzbHDIx68IGdyXt7A9f
	M6GBdH//i+N69h/FvCQ7jBzixbEFrrevkvvqt1pOqjG3z6sHdlLx
X-Google-Smtp-Source: AGHT+IGNY6EcPl/21aHOSW7rMsfhNA8T2CiObOVpd3bhZMKlpnr9N73J1g+kjE2dQz2GwAijuam/bQ==
X-Received: by 2002:a17:903:451:b0:231:fc67:f8e3 with SMTP id d9443c01a7336-231fc680227mr174447585ad.51.1747839481264;
        Wed, 21 May 2025 07:58:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:82ea:3296:41f6:56cd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231daf86774sm92423675ad.103.2025.05.21.07.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:58:00 -0700 (PDT)
Date: Wed, 21 May 2025 07:57:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jonathan Cameron <jic23@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, dakr@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, geert@linux-m68k.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] driver core: platform: Use devres group to free driver
 probe resources
Message-ID: <fgl4w5uhxci7rrbdigtni72vveb2gqemh6iccz4qruqkek5rja@rzwkcjg6hkid>
References: <20250330163129.02f24afb@jic23-huawei>
 <5bca6dfd-fe03-4c44-acf4-a51673124338@tuxon.dev>
 <95f5923f-7a8f-4947-b588-419525930bcb@tuxon.dev>
 <CAPDyKFoMqmCFBoO8FwQe2wHh2kqQi4jUZNFyiNckK7QhGVgmvg@mail.gmail.com>
 <c3a2950a-17ff-444a-bee7-af5e7e10e2bf@tuxon.dev>
 <CAPDyKFozR4qDq4mzcZBK-LcoPf=fGyuJTXwdt=Ey+_DcQOAp0g@mail.gmail.com>
 <4o3wo76st7w6qwyye3rrayuo2qx773i6jfzcnbkhdj76ouh7ds@3e2mblehkgwf>
 <CAPDyKFqMB7XutXba73YHx1X4rm6uc3Fz6yMZ8yM=wgduEmgUDg@mail.gmail.com>
 <a20fc6ee-c6c3-4013-b175-4918b9a44380@tuxon.dev>
 <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpbeLJUiB_xQbqDib+-8Q3AcJNVg+DuEcqmVGMbFdNxwA@mail.gmail.com>

On Wed, May 21, 2025 at 02:37:08PM +0200, Ulf Hansson wrote:
> On Wed, 21 May 2025 at 07:41, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> >
> > Hi, Ulf,
> >
> > On 20.05.2025 15:09, Ulf Hansson wrote:
> > > For example, even if the order is made correctly, suppose a driver's
> > > ->remove() callback completes by turning off the resources for its
> > > device and leaves runtime PM enabled, as it relies on devres to do it
> > > some point later. Beyond this point, nothing would prevent userspace
> > > for runtime resuming/suspending the device via sysfs.
> >
> > If I'm not wrong, that can't happen? The driver_sysfs_remove() is called
> > before device_remove() (which calls the driver remove) is called, this
> > being the call path:
> >
> > device_driver_detach() ->
> >   device_release_driver_internal() ->
> >     __device_release_driver() ->
> >       driver_sysfs_remove()
> >       // ...
> >       device_remove()
> >
> > And the driver_sysfs_remove() calls in the end __kernfs_remove() which
> > looks to me like the place that actually drops the entries from sysfs, this
> > being a call path for it:
> >
> > driver_sysfs_remove() ->
> >   sysfs_remove_link() ->
> >     kernfs_remove_by_name() ->
> >       kernfs_remove_by_name_ns() ->
> >         __kernfs_remove() ->
> >
> > activating the following line in __kernfs_remove():
> >
> > pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
> >
> > leads to the following prints when unbinding the watchdog device from its
> > watchdog driver (attached to platform bus) on my board:
> > https://p.fr33tux.org/935252
> 
> Indeed this is a very good point you make! I completely overlooked
> this fact, thanks a lot for clarifying this!
> 
> However, my main point still stands.
> 
> In the end, there is nothing preventing rpm_suspend|resume|idle() in
> drivers/base/power/runtime.c from running (don't forget runtime PM is
> asynchronous too) for the device in question. This could lead to that
> a ->runtime_suspend|resume|idle() callback becomes executed at any
> point in time, as long as we haven't called pm_runtime_disable() for
> the device.

So exactly the same may happen if you enter driver->remove() and
something calls runtime API before pm_runtime_disable() is called.
The driver has (as they should be doing currently) be prepared for this.

> 
> That's why the devm_pm_runtime_enable() should be avoided as it simply
> introduces a race-condition. Drivers need to be more careful and use
> pm_runtime_enable|disable() explicitly to control the behaviour.

You make it sound like we are dealing with some non-deterministic
process, like garbage collector, where runtime disable done by devm
happens at some unspecified point in the future. However we are dealing
with very well defined order of operations, all happening within
__device_release_driver() call. It is the same scope as when using
manual pm_runtime_disable(). Just the order is wrong, that is it.

Thanks.

-- 
Dmitry

