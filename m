Return-Path: <linux-iio+bounces-20465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF870AD5C5C
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A9D7A44F3
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC307221562;
	Wed, 11 Jun 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs6rp9oZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFBD20766E;
	Wed, 11 Jun 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659712; cv=none; b=rUP+hsPcrucijx0w2id7WVUoGf+SghBPfXvTd8ZJGDizdMfzUHEWrClxIprzZsfC3GUAEgaXhCaYv6qZLSB8NRkzqFcepxWtE1SS2n5TpZSs1VVYmEwAZTQ2vcHvRsh92WmtWr2Dg4FtKf9UtiQmSY5FU6XQGdjcTLBVFvrM9VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659712; c=relaxed/simple;
	bh=4T6TefxymGuT/EcWLXnyw9C8XuFwlxDI5hIHJ4PoN8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk6++MDccgx9GT89nVWBURSJBkTDQSDhngDMVyENaP1tG/Jgphb6LOoIAzCu+T/q2VFlyHHZf90Cv/e2Iz/BL7w8/tslXOzSn0rmWSIauulsofU5zzydnuurBwGzGhAiWAA54iqLek2ZjT6NBhX71Wo+8M5HUhmTzIbL9Pm1iK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs6rp9oZ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234d366e5f2so220215ad.1;
        Wed, 11 Jun 2025 09:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749659710; x=1750264510; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moYDdCBKQo1o7OL3pKThQFqO2J9Mz1W/woNo6FWp4v0=;
        b=Zs6rp9oZniOEPp6xVStk5JjIZy/dPERIQRtjK2uUn9dpJqrIOgqTCUcoXo1KfwnZQ5
         O+Pdmb4c5j9SPribFns3fKDO4BW1Rh1+4cMJ87ad6tVE0Za+x+6WpbMDzRXX9xX0u49C
         Psd0PEXrH1i0B9KjdpP3pfJ/taSnrcvVlsOUqPdgpF2LUroN/BMPLePyUBqEtlQjTzzg
         iPFcjn5juuUXoGjDOiF64K3d8+y0jUqZ5lTeyDurYb8/L8Gsf+y4kEd+2b3+TKs0N2C1
         V12cBG5fEwBK/xRvOx00qkA8q8JpVpiil1ltStRXIt8qZmo2Lp1z7E+kJAhW+cKQ1uee
         rVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749659710; x=1750264510;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moYDdCBKQo1o7OL3pKThQFqO2J9Mz1W/woNo6FWp4v0=;
        b=kjDgq24TiIroAvmYUVZt1RUOQi8yLoJRBozYpu4O0WUpt1hxlzeuN5M9tXXLtnZZOX
         wKiWPwnPzY5G0RyTg+S74FnMdmlWrJa7vXxfutg9EMxNmw7THdKuCq9PFtHOVAO7mysd
         3MY3CmY6J2eeyCOTgTxbQQcxUq5NuR8rR2H4c412fLNpDH/6ZaqS5wgsb9GQZ2H/4DIF
         hibwN32d+0I9UJCI3s9qvL7B3XCtsfSzqPKpMmIco4J9p6uMfm3npJeGVxMmGVBv6k6o
         4DRFHEhlo8ya+JffKwcQY1sqmttGxGvuv+DP6p54KAYN7PNMcrrxIMy7j3yOet2DPXw4
         YfRA==
X-Forwarded-Encrypted: i=1; AJvYcCU1MKPQZk7iPuqx+JWgAPO/WHWJT0qzgRgexsr/3rRjEPJRdupYYPSPzGH5+83lvPwrPgGjQ2sIrzU=@vger.kernel.org, AJvYcCVBfWSA2GVnq9h+mF7/DOTzEXltTNLcRLXOlChwV4ZZUoqc09/ByQ1XaRICkFTf9g5AZi2kxaIYZ5dHiY+eioxf2Ts=@vger.kernel.org, AJvYcCWvAn9sgV+31p2aicamMPngGAL6cFGOUYJO70s2LUYwYtf6M/MyU3/IqnwUGBkRBzXlB8cgyh3RgVhIe0SL@vger.kernel.org, AJvYcCXBQu7iwUbPvHky84f+ca8ZKg0iIglRDTCbirgVhepKTjfePc32W04GhTtAe1HlDKcB6S4UBnKRYLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/btEA4Mg+gUtoIuTd4XMY4CWAlyad8YXOl3Ih8IaZNRFUxm4
	zsK4LPIE/r7ZVPSPI54PTevNmg86KTdrvGahICI4h91tugsIQ3OipDkS
X-Gm-Gg: ASbGncsRsK5Xq7quSFnecf7oTQF5YXu4XRrJI2JDawJVvbOtkBqp+K6TAE60yjOHezL
	fur+5ehah0bH69Q+rV2/S3Ff8IgM72GF60KLRzFouTochip0HA3SoBOmcjme/38fOQq9w/fjpiA
	eOYOTrPx9nTIxIA8/6OzNgP5V7M0nqAv9vLU4lX4//BaPeyB1m9RIEEe1w2ZgM9q6Yr9zA8TdSa
	HepG7NhpiIaIJ9XAEth7H4QO0Q264S4msuvn+0Z4uvU3UN8tK22lu5xbcJqMwWXpeYmqFho20hL
	vqBfhe+7PSX7XKfdyZVEyBj55jWZbHWB7CR/qJgVnh4kTJ+Eg/kTkdDUiKNJPQ==
X-Google-Smtp-Source: AGHT+IGFMdjlBJbDVBzlFLVjv8c8nQwxnnks3iI6iwDj44idHGQ1w7rK96VSZvYthFmcR0aZsdS8UA==
X-Received: by 2002:a17:902:f54c:b0:235:ea0d:ae10 with SMTP id d9443c01a7336-23641a9a44amr62858495ad.12.1749659709804;
        Wed, 11 Jun 2025 09:35:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cc6e:a0f4:a9c8:328])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360340b735sm89936435ad.190.2025.06.11.09.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:35:09 -0700 (PDT)
Date: Wed, 11 Jun 2025 09:35:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Claudiu <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org, dakr@kernel.org, len.brown@intel.com, 
	pavel@kernel.org, ulf.hansson@linaro.org, daniel.lezcano@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bhelgaas@google.com, 
	geert@linux-m68k.org, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	fabrizio.castro.jz@renesas.com, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v3 1/2] PM: domains: Add devres variant for
 dev_pm_domain_attach()
Message-ID: <yd4nhx4b3dbbsru747l2mxwo66xrz3kbyhjpo5kgiqrfvxbyk4@exebi7owkezd>
References: <20250606111749.3142348-1-claudiu.beznea.uj@bp.renesas.com>
 <20250606111749.3142348-2-claudiu.beznea.uj@bp.renesas.com>
 <CAJZ5v0i_Ey+OVpSZHXru=tubMaZi=y-uOh_0M6zmWZ2DqqA7Vg@mail.gmail.com>
 <zhjytvj35lknj7v3jhva3n3nbv6qctvqgykwyi5huj6omet7lz@wchd7f4p4dpv>
 <CAJZ5v0hsT-Q2hz=qoBo409oungaCmexJwwGheN7KRLFqz=6_Dw@mail.gmail.com>
 <20250607140600.76e87ea5@jic23-huawei>
 <CAJZ5v0jqZ6gYKb85dpR-X5RwFeUBcbbcJ_b-AOe+JypBXod-MA@mail.gmail.com>
 <20250611172307.37c9b725@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250611172307.37c9b725@jic23-huawei>

On Wed, Jun 11, 2025 at 05:23:07PM +0100, Jonathan Cameron wrote:
> On Mon, 9 Jun 2025 21:59:57 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Sat, Jun 7, 2025 at 3:06 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > On Fri, 6 Jun 2025 22:01:52 +0200
> > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > >
> > > Hi Rafael,
> > >  
> > > > On Fri, Jun 6, 2025 at 8:55 PM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:  
> > > > >
> > > > > On Fri, Jun 06, 2025 at 06:00:34PM +0200, Rafael J. Wysocki wrote:  
> > > > > > On Fri, Jun 6, 2025 at 1:18 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:  
> > > > > > >
> > > > > > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > > > >
> > > > > > > The dev_pm_domain_attach() function is typically used in bus code alongside
> > > > > > > dev_pm_domain_detach(), often following patterns like:
> > > > > > >
> > > > > > > static int bus_probe(struct device *_dev)
> > > > > > > {
> > > > > > >     struct bus_driver *drv = to_bus_driver(dev->driver);
> > > > > > >     struct bus_device *dev = to_bus_device(_dev);
> > > > > > >     int ret;
> > > > > > >
> > > > > > >     // ...
> > > > > > >
> > > > > > >     ret = dev_pm_domain_attach(_dev, true);
> > > > > > >     if (ret)
> > > > > > >         return ret;
> > > > > > >
> > > > > > >     if (drv->probe)
> > > > > > >         ret = drv->probe(dev);
> > > > > > >
> > > > > > >     // ...
> > > > > > > }
> > > > > > >
> > > > > > > static void bus_remove(struct device *_dev)
> > > > > > > {
> > > > > > >     struct bus_driver *drv = to_bus_driver(dev->driver);
> > > > > > >     struct bus_device *dev = to_bus_device(_dev);
> > > > > > >
> > > > > > >     if (drv->remove)
> > > > > > >         drv->remove(dev);
> > > > > > >     dev_pm_domain_detach(_dev);
> > > > > > > }
> > > > > > >
> > > > > > > When the driver's probe function uses devres-managed resources that depend
> > > > > > > on the power domain state, those resources are released later during
> > > > > > > device_unbind_cleanup().
> > > > > > >
> > > > > > > Releasing devres-managed resources that depend on the power domain state
> > > > > > > after detaching the device from its PM domain can cause failures.
> > > > > > >
> > > > > > > For example, if the driver uses devm_pm_runtime_enable() in its probe
> > > > > > > function, and the device's clocks are managed by the PM domain, then
> > > > > > > during removal the runtime PM is disabled in device_unbind_cleanup() after
> > > > > > > the clocks have been removed from the PM domain. It may happen that the
> > > > > > > devm_pm_runtime_enable() action causes the device to be runtime-resumed.  
> > > > > >
> > > > > > Don't use devm_pm_runtime_enable() then.  
> > > > >
> > > > > What about other devm_ APIs? Are you suggesting that platform drivers
> > > > > should not be using devm_clk*(), devm_regulator_*(),
> > > > > devm_request_*_irq() and devm_add_action_or_reset()? Because again,
> > > > > dev_pm_domain_detach() that is called by platform bus_remove() may shut
> > > > > off the device too early, before cleanup code has a chance to execute
> > > > > proper cleanup.
> > > > >
> > > > > The issue is not limited to runtime PM.
> > > > >  
> > > > > >  
> > > > > > > If the driver specific runtime PM APIs access registers directly, this
> > > > > > > will lead to accessing device registers without clocks being enabled.
> > > > > > > Similar issues may occur with other devres actions that access device
> > > > > > > registers.
> > > > > > >
> > > > > > > Add devm_pm_domain_attach(). When replacing the dev_pm_domain_attach() and
> > > > > > > dev_pm_domain_detach() in bus probe and bus remove, it ensures that the
> > > > > > > device is detached from its PM domain in device_unbind_cleanup(), only
> > > > > > > after all driver's devres-managed resources have been release.
> > > > > > >
> > > > > > > For flexibility, the implemented devm_pm_domain_attach() has 2 state
> > > > > > > arguments, one for the domain state on attach, one for the domain state on
> > > > > > > detach.  
> > > > > >
> > > > > > dev_pm_domain_attach() is not part driver API and I'm not convinced at  
> > > > >
> > > > > Is the concern that devm_pm_domain_attach() will be [ab]used by drivers?  
> > > >
> > > > Yes, among other things.  
> > >
> > > Maybe naming could make abuse at least obvious to spot? e.g.
> > > pm_domain_attach_with_devm_release()  
> > 
> > If I'm not mistaken, it is not even necessary to use devres for this.
> > 
> > You might as well add a dev_pm_domain_detach() call to
> > device_unbind_cleanup() after devres_release_all().  There is a slight
> > complication related to the second argument of it, but I suppose that
> > this can be determined at the attach time and stored in a new device
> > PM flag, or similar.
> 
> That options sounds good to me.  I think this moves dev_pm_domain_detach()
> call into the the driver core / perhaps device_unbind_cleanup().  It's a noop
> if a domain was never attached so that should be fine.
> 
> Given that second parameter, I guess we can't move the dev_pm_domain_attach()
> into the driver core as well so it is a little odd wrt to balance,
> but with some documentation that is probably fine.

It is going to be confusing IMO and might lead to ordering issues again
if there are more resources allocated by bus probe() before domain
attach is called.

I know Rafael does not consider dev_pm_domain_attach() a "driver" API
(although I do not see much difference between driver and bus probe
code), but maybe we can solve this by using different name
(devres_controlled_pm_domain_attach() instead of
devm_pm_domain_attach()?).

OTOH we have devm_pm_domain_attach_list() already which is I guess
driver-level API...

Thanks.

-- 
Dmitry

