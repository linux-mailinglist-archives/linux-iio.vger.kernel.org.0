Return-Path: <linux-iio+bounces-9011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E859689B3
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 16:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57737284B44
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 14:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F984210193;
	Mon,  2 Sep 2024 14:17:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7A919E97B;
	Mon,  2 Sep 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725286634; cv=none; b=IIalNgPC+61RNYzLCEnxqll1OodoarSGJTthWw5Vp/V6Pk8xCl6ztYjebwRZytlCuy+K+cD2MEFIYS1VXi9YKJShSvk2RjtUSQP9xGgpiCrdr4YsVakC6CC9fGwTRnNY4TSlTpcQjY1qc7xhWhlsLiHasbNleLX+tdoaraBm/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725286634; c=relaxed/simple;
	bh=DiqcYK8CgR5lVnVbP4NtFJ4uxP3RlOM1WRhaMpOIZg0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eht5Cw1rS6zf+vimIkqNfxerUIDpzAtfvJgsM2t+p6chihMK36RwU0q3cp3fgn1niA1wznnbKWuUgnlzYxBL1gfHdRS6AyRH76jso9lv2qBWJKPTyRc8w8WBzORWJ/E3Duai13yFWCjDhTiY4VCmaR9p98L6wHISmzTNfSvysPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wy9ht5zqTz6K5kP;
	Mon,  2 Sep 2024 22:13:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EC29140A08;
	Mon,  2 Sep 2024 22:17:08 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 2 Sep
 2024 15:17:07 +0100
Date: Mon, 2 Sep 2024 15:17:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>
CC: Jonathan Cameron <jic23@kernel.org>, Conor Dooley <conor@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "jdelvare@suse.com"
	<jdelvare@suse.com>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
Message-ID: <20240902151706.0000334f@Huawei.com>
In-Reply-To: <BE1P281MB2420D75334A568E60823BE48EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
	<20240830-chaos-unrivaled-04c5c4c6add9@spud>
	<20240831132159.2073994f@jic23-huawei>
	<BE1P281MB2420D75334A568E60823BE48EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 2 Sep 2024 13:24:59 +0000
"Sperling, Tobias" <Tobias.Sperling@Softing.com> wrote:

> > > > +  ti,mode:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint8
> > > > +    description: |
> > > > +      Operation mode
> > > > +      Mode 0 - Manual mode. A channel is only sampled when the according  
> > input  
> > > > +        in the sysfs is read.
> > > > +      Mode 1 - Auto mode. All channels are automatically sampled  
> > sequentially.  
> > > > +        Reading an input returns the last valid sample. In this mode further
> > > > +        features like statistics and interrupts are available.
> > > > +    default: 0  
> > >
> > > I don't think this ti,mode property is suitable for bindings. sysfs is a
> > > linux implementation detail, when to do sampling is an implementation
> > > detail of your driver. Bindings are only supposed to describe properties
> > > of the hardware, not set software policy.  
> > 
> > Agreed. With an IIO driver this will become a switch based on what usespace
> > interfaces are enabled.
> > So if events are on or buffered data capture, enable automode.
> > If just sysfs reads, then manual mode is fine.  
> 
> Not quite sure if I understood you correctly. With the mode I intended to give
> control about the sampling behavior.
> In manual mode channels are only sampled if they are accessed/read.
> In auto mode they are sampled all the time sequentially. This also offers to use
> some extended features, like triggering an interrupt if a measurement crosses a
> defined limit.
> So the mode mainly affects the hardware behavior and just offers the possibility
> to catch that in userspace, if configured accordingly, but that's not a must-have.
> 
> Anyway, did I understood it correctly, that you suggest to configure the mode
> according some symbols in the kconfig and check that with #ifdef? Do you have
> the specific symbol names for me or a driver as example, so I can have a look?
No, this is not a build time of firmware config question. It is a question of
what the user is 'doing' with the device. Configure the mode according to what
userspace has enabled.

If it enables threshold detection, then turn on continuous mode.
If it enables capture of data via a chardev (so fast path) then turn on continuous
mode.  If neither of those, then run in manual mode.

Jonathan

> 
> Thanks and regards
> Tobias
> 


