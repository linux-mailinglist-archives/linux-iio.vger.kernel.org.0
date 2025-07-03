Return-Path: <linux-iio+bounces-21286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F11AF6CED
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 10:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509EE4A0ECF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8522C3252;
	Thu,  3 Jul 2025 08:31:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB028EBE5;
	Thu,  3 Jul 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531489; cv=none; b=qhlacOESFq/km0QziTMn4udc85h6zF3r/tC106xlDdJgnv5Si/Z+w7T8JRaOi5vUEQvDr70F0aI3ToAqnCByGY+kAhFsoRkjHiMUV/xWps5OTsP64/JcVzZusDWHyMazQSu/grDH4xESJ9SmG0dfqu8tR/2W+nIw41x8+QW1axM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531489; c=relaxed/simple;
	bh=UDBuKHCmGElPbXDHiKnDguamX1UrXufRTkYZ2HjchWQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulHrK5VFIaOoB+Kards+fIBT57kXw0euDzFxlz4og8D6uR7A4s4cl4E6XRNv/JgfmCWSCrmuMBfM4YR9JbCwJIjtAU8E+IrDoLnsAjMKcmMiWrPTHYwNwGDE4KsWYPGIl7Azh3ry7fXoD29n198U1kjyPgVzDNjwJMXI7/uyoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXqfN46Y1z6L5dn;
	Thu,  3 Jul 2025 16:28:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2216D140371;
	Thu,  3 Jul 2025 16:31:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Jul
 2025 10:31:23 +0200
Date: Thu, 3 Jul 2025 09:31:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, David Lechner
	<dlechner@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Jonathan Santos
	<Jonathan.Santos@analog.com>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Next Mailing List
	<linux-next@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iio tree with the spi tree
Message-ID: <20250703093122.00000684@huawei.com>
In-Reply-To: <20250703163824.2f08d866@canb.auug.org.au>
References: <20250703163824.2f08d866@canb.auug.org.au>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 16:38:24 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the iio tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   e47a324d6f07 ("dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI")
> 
> from the spi tree and commit:
> 
>   0dd88eaa7126 ("dt-bindings: trigger-source: add generic GPIO trigger source")
> 
> from the iio tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
Thanks Stephen,

David, do you prefer these merged or kept as separate entries?

I don't think it matters either way in practice though this is the
more complex merge (the other being just putting the blocks in order.

We can put a note in the pull request on preference but ultimately Linus
will resolve this however he prefers! 

Jonathan


> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc MAINTAINERS
> index dd764b947dab,d0809d62ff48..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -25333,19 -25201,15 +25341,20 @@@ TRADITIONAL CHINESE DOCUMENTATIO
>   M:	Hu Haowen <2023002089@link.tyut.edu.cn>
>   S:	Maintained
>   W:	https://github.com/srcres258/linux-doc
>  -T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  +T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
>   F:	Documentation/translations/zh_TW/
>   
> + TRIGGER SOURCE
> + M:	David Lechner <dlechner@baylibre.com>
> + S:	Maintained
> + F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> + F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> + 
>  +TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
>  +M:	David Lechner <dlechner@baylibre.com>
>  +S:	Maintained
>  +F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
>  +
> - TRIGGER SOURCE - PWM
> - M:	David Lechner <dlechner@baylibre.com>
> - S:	Maintained
> - F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> - 
>   TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
>   M:	Dan Williams <dan.j.williams@intel.com>
>   L:	linux-coco@lists.linux.dev

