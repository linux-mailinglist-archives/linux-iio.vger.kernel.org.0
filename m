Return-Path: <linux-iio+bounces-11865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CD29BA538
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C7B281D3D
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322B5166F17;
	Sun,  3 Nov 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr8p3Lcn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7F1448E3;
	Sun,  3 Nov 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730632235; cv=none; b=Lgyk9Rzk/e3pE34TIPgZBjx849kd/wOry/SmJsLbGXKeigsVdRd3iARjUH2fad/77yBha+Y43dIQ1sgiGq0U9kM7ZcLHASmBSH2JGNcGj6UmwExNybzk9GhzGH6/OcJTSErfH4ii87BBWJrLVbetDZx1elqeZcRDOdNzFYwQBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730632235; c=relaxed/simple;
	bh=BScRYTaYaI9EvdCsPkFqsQxL7Upg6dmcbroS9gwIzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PhHNDR8+blYlv3oYY4R4IMm5uNOm1eLtjnPkQxCVNKF3HkY1ALxHPiTndbCUSE1xXl2dKpsE9hT/WqEXqGdFLuCSVVtdSx0d9BfAp1TMPIOS560t16hqlhwDcQJzG2TL2dOsJOgtuC7CbGnyUpGwDcs3SLVcgyzS4P2WfxGc/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr8p3Lcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4422AC4CECD;
	Sun,  3 Nov 2024 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730632234;
	bh=BScRYTaYaI9EvdCsPkFqsQxL7Upg6dmcbroS9gwIzgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dr8p3LcnkJ+zWC51o6DpVLq8WmqlDzCY78ARuw5odx63AUF51vGUuqKTvhj+d+DL5
	 Jsd1tItJN7yKxuMetNgKp/Mrj3+LRHd2waSdVD1u8/mNrvSEu3v3Cz+WQelRN4kLRS
	 ZRtF+l9MjSZn2fuTae616DO9VAg8m6I3Cvxfv/wRThwO1KIpO0gE7y5kjOtufLd4ff
	 G9Mdw1z9MOurg7GQAu1p+jpeJ6qe/r8unZeZLGs8HIYuir9AlDB2s24Tpb+7WvHP8b
	 zVjvPqWP4gudKVas9QNOxMbpym2WKu/J2qa23bwGdIo2lCOKGi0TfVrgf0/vJTNRmP
	 L236W3Nky3JQg==
Date: Sun, 3 Nov 2024 11:10:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: victor.duicu@microchip.com, matteomartelli3@gmail.com, lars@metafoo.de,
 marius.cristea@microchip.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
Message-ID: <20241103111023.691164a2@jic23-huawei>
In-Reply-To: <ZyaB9G1baF10FzZD@surfacebook.localdomain>
References: <20241031065205.50154-1-victor.duicu@microchip.com>
	<ZyaB9G1baF10FzZD@surfacebook.localdomain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 Nov 2024 21:48:04 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Thu, Oct 31, 2024 at 08:52:05AM +0200, victor.duicu@microchip.com kirjoitti:
> > From: Victor Duicu <victor.duicu@microchip.com>
> > 
> > This patch implements ACPI support to Microchip pac1921.
> > The driver can read shunt resistor value and label from ACPI table.  
> 
> This ID might be okay, but can we please have:
> 1) the list of the models (or a model) of the device on the market that has this;
> 2) ACPI DSDT excerpt of the respective Device object?
> 
> (I mean a laptop, tablet, phone or other device that has this sensor described
> in the ACPI)

For a valid ID used in a patch submitted by an employee of the relevant
company this is a steep ask.  As far as I'm concerned it is definitely not
a requirement (unlike for non compliant IDs!) There is no reason why a
device might be public at this time. 

For a good upstream first company almost all IDs go into the kernel
'before' device announcement or sales.  I very much want to encourage
that not put potential barriers in the way.

So Victor, if you can provide the info Andy requested, then great but if not
feel free to say so. (+ the snippet is useful anyway and is unlikely
to contain anything confidential.) 

Jonathan



