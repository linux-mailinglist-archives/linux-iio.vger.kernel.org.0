Return-Path: <linux-iio+bounces-21394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A64AFA4A0
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E416E17B54D
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8A203710;
	Sun,  6 Jul 2025 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAvw6c1I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7627202998;
	Sun,  6 Jul 2025 10:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751799061; cv=none; b=PPspsyVQ98rvI5n4fn/RffJPB31Ewn7OyJPkncSIss5EuHq8WNSEET6cvW5i6cuTPsmDZuNt+p6ts3Sy5Q4QcQN4RaEGPpb5shbBPEmD6uBkxqEnM71ufM1tu2SGu5v8Tm4qZ8yM032AvXRXYhMwXUhGPSjmcJ3jc/Mlg7memLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751799061; c=relaxed/simple;
	bh=ml2b361SMuIDtACK5do4dE6I0wF/3KkJQJg3sV0FNGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzaV8sK/ZwUAS4Hg7pFKGvD6iVhD/WM6BZV1OHr5SqSSgL3nFMJpIQfqn+Ds2yLOx8PN0LpV234pMCAa5DHD+WEQrE4M/dE4qhFH8uT4T5H0xoSmfXPLNLpCW6K79pCUJ9FjT6SZ8EN5yP9KvgYUT9yCgHaufarEjh3IifBGZn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAvw6c1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC93C4CEED;
	Sun,  6 Jul 2025 10:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751799061;
	bh=ml2b361SMuIDtACK5do4dE6I0wF/3KkJQJg3sV0FNGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SAvw6c1Iurf707yUGFwuEdGsgZeA1ZmXAW3Mx0CaLVDaGs1rrqhZWn+HaF/AyR178
	 nDFAHUIygoWDqCodhVD/SE5dxxmQ/peTGx+Q0IUkTiFFgHwVkzD/UxuvgxDNKAD8rf
	 0JVYta5W34r2StsDjZ2RMFfPOa9iPU9xiP4B2nq/a4iEcGMIviCf2fOQETyMW4I/tG
	 fm/7lXg26mF35iIKiIPe90mpq/mOvgbzXVB/I/oZ5Xhb6WqZGJsaD8OXPkAnXeloZv
	 w0cryaKKMoA4RxmCzxkEdYx2ADVihuagjwkcie245qQ9MYCpnXORVSnanc+OIg+Esk
	 Hq5Z+FDqcyM8g==
Date: Sun, 6 Jul 2025 11:50:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>, Jonathan Santos
 <Jonathan.Santos@analog.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: linux-next: manual merge of the iio tree with the spi tree
Message-ID: <20250706115053.368ce9e9@jic23-huawei>
In-Reply-To: <b0b0443d-143f-4e41-b8b8-91c6726e838f@baylibre.com>
References: <20250703163824.2f08d866@canb.auug.org.au>
	<20250703093122.00000684@huawei.com>
	<b0b0443d-143f-4e41-b8b8-91c6726e838f@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 07:28:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/3/25 3:31 AM, Jonathan Cameron wrote:
> > On Thu, 3 Jul 2025 16:38:24 +1000
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >   
> >> Hi all,
> >>
> >> Today's linux-next merge of the iio tree got a conflict in:
> >>
> >>   MAINTAINERS
> >>
> >> between commit:
> >>
> >>   e47a324d6f07 ("dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI")
> >>
> >> from the spi tree and commit:
> >>
> >>   0dd88eaa7126 ("dt-bindings: trigger-source: add generic GPIO trigger source")
> >>
> >> from the iio tree.
> >>
> >> I fixed it up (see below) and can carry the fix as necessary. This
> >> is now fixed as far as linux-next is concerned, but any non trivial
> >> conflicts should be mentioned to your upstream maintainer when your tree
> >> is submitted for merging.  You may also want to consider cooperating
> >> with the maintainer of the conflicting tree to minimise any particularly
> >> complex conflicts.
> >>  
> > Thanks Stephen,
> > 
> > David, do you prefer these merged or kept as separate entries?  
> 
> Ah, shoot, I forgot that we had added the gpio one and just made
> one section like this.
> 
> I think it would make sense to also merge the new adi one with
> the reset to keep things compact.
> 
Is there a path to do that cleanly given the multiple trees things are
coming from?  Maybe this is a let things resolve whatever way this cycle
and tidy up next?

> > 
> > I don't think it matters either way in practice though this is the
> > more complex merge (the other being just putting the blocks in order.
> > 
> > We can put a note in the pull request on preference but ultimately Linus
> > will resolve this however he prefers! 
> > 
> > Jonathan
> > 
> >   
> >> -- 
> >> Cheers,
> >> Stephen Rothwell
> >>
> >> diff --cc MAINTAINERS
> >> index dd764b947dab,d0809d62ff48..000000000000
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@@ -25333,19 -25201,15 +25341,20 @@@ TRADITIONAL CHINESE DOCUMENTATIO
> >>   M:	Hu Haowen <2023002089@link.tyut.edu.cn>
> >>   S:	Maintained
> >>   W:	https://github.com/srcres258/linux-doc
> >>  -T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
> >>  +T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
> >>   F:	Documentation/translations/zh_TW/
> >>   
> >> + TRIGGER SOURCE
> >> + M:	David Lechner <dlechner@baylibre.com>
> >> + S:	Maintained
> >> + F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
> >> + F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> >> + 
> >>  +TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
> >>  +M:	David Lechner <dlechner@baylibre.com>
> >>  +S:	Maintained
> >>  +F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
> >>  +
> >> - TRIGGER SOURCE - PWM
> >> - M:	David Lechner <dlechner@baylibre.com>
> >> - S:	Maintained
> >> - F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
> >> - 
> >>   TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
> >>   M:	Dan Williams <dan.j.williams@intel.com>
> >>   L:	linux-coco@lists.linux.dev  
> 
> 


