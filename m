Return-Path: <linux-iio+bounces-10813-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 246BB9A53B3
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 13:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F59B21D42
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A413318E028;
	Sun, 20 Oct 2024 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ8o3+Cb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB424C7D;
	Sun, 20 Oct 2024 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423341; cv=none; b=mmgWayWYZLGE8kXEdbasfSD5ok0YozLRE1OKFYYTU8BS+rx05AXKUGglfdtKCTGYnBS2GWv4VokiivVAdyTV2JpYVmYXHrM9nRxbBoT/g9YRWwN/fhkn9BvQoygo35exaC0tc5sQUdhLasvQHtOF14bNzgBRhEOmtRkLqaEwAeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423341; c=relaxed/simple;
	bh=+fygpZbqdJBNFeshez2EXUwOdxXSX4xJ4QEaqrws03g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwgMM0jx8knA+kyJXC6b6H8WAbFeYtWu9dvZ29EcT+VJKJX4a6yapZ5C6pW4DumKZrbYeHhO6n5dJ3eGDFiUgwOeL017R3Kyezd7RhN2viEQYAhIOUUS79XbucGJzH9te/KJ0fGQQ0jnMvsgpVmelX/vNIjT1bKzr3/mXc2unIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ8o3+Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DFAC4CEC6;
	Sun, 20 Oct 2024 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729423336;
	bh=+fygpZbqdJBNFeshez2EXUwOdxXSX4xJ4QEaqrws03g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cQ8o3+Cb4Xne7znnFANFwv8cM1qw4/S+RTDU3+828ZeOTKMleQJ5/nGfWC54H/dpo
	 b6p7/IR9ZrNzfDHz3jVW6PWqKprzghG5J4Y8gF4WDUasKbpWOpR/v29pInULkBz3yk
	 pWtBUfbA0RlZhAYc0IBgQ3Ndr31Hvb6qZjxxzmI8dOs83uiQ5+Ea58Wd+mQb3GCrYE
	 VF6V3C2gHn+maDl8vD82ZpcbBXuHRRGLaOkENIJuQC/IrMbfqk3ygvaaTx9tieoUhS
	 QUvSgK0iup9ApuofdBemOEBJfG9Q7vPtXDwAslT2YvlgORUN0hpIMm3vhdobiQZc3O
	 ZKNv7Pc0iVhrw==
Date: Sun, 20 Oct 2024 12:22:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Nuno Sa
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, George Mois
 <george.mois@analog.com>, Ana-Maria Cusco <ana-maria.cusco@analog.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] Documentation: ABI: added filter mode doc in
 sysfs-bus-iio
Message-ID: <20241020122211.1b722092@jic23-huawei>
In-Reply-To: <20241020120624.5f0f8494@jic23-huawei>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
	<20241014143204.30195-3-ramona.nechita@analog.com>
	<20241020120624.5f0f8494@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 12:06:24 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 14 Oct 2024 17:31:59 +0300
> Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:
> 
> > The filter mode / filter type property is used for ad4130
> > and ad7779 drivers, therefore the ABI doc file for ad4130
> > was removed, merging both of them in the sysfs-bus-iio.
> > Since one of the drivers is available from 6.1, the version
> > has been set to 6.1 for these attributes.
> > 
> > Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> > ---  
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6011af70c12e..2de269df7d3a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1262,7 +1262,6 @@ M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
> >  L:	linux-iio@vger.kernel.org
> >  S:	Supported
> >  W:	https://ez.analog.com/linux-software-drivers
> > -F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130  
> ?  Spurious change.
Ignore that.  Change is correct I'm just being slow this morning!

Jonathan

> 
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> >  F:	drivers/iio/adc/ad4130.c
> >    
> 
> 


