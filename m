Return-Path: <linux-iio+bounces-18254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710DA938DB
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B6D19E5A6D
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E401D5AA7;
	Fri, 18 Apr 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAo1JDkb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF87EEC8;
	Fri, 18 Apr 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988031; cv=none; b=Nt2l7s0jxhRt5JyCUBxfTzQPTvtovtu4dslgplc0xs/GINNfJJTEbf0io1ViG6Sd4VFmHotvFaPx+C3L9M9tydpC1FBIQOlF/2oB3hSZnFm9bMCTePOQoehh16ni9XBq84sa8GHaKNaDY8sa+9rXZtKE96morCOweUlfBZV8G+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988031; c=relaxed/simple;
	bh=g34gBYb6R4BnqUhzVUDHFk2+n+AlDlCAPcckXvBMohc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PptK2bpIzyN5fI6y+TFgkTJV+OnxnqeLB4ayI2kxZR0DDjNdiTL2BFKol1DVB8o0jfy6PtOP8H34n+gY6UR9kl7ailB5TFITZk0VJsi0bxUN6YyaxoXi5F614fG8qWc1iFzS3Ixq6JS5XrNfsJ7QP7yqcAsl0cgRr+XuRc3EUPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAo1JDkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB144C4CEE2;
	Fri, 18 Apr 2025 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988030;
	bh=g34gBYb6R4BnqUhzVUDHFk2+n+AlDlCAPcckXvBMohc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jAo1JDkb8KmWHnFshBsCPXK7197UdRywGCALDTHTnPjKS4ac7sOaPgTU9DHq08Ion
	 +mG44IldDVLUQ3NjyygzJ37ZBWDMTz2/lSLBr4VKI6HSO9TVoDKorJKD09nwDtRoDJ
	 bvQdppchkSYzPYKCVI1B90pstwj2JFyowpx+aDv3/WPW9Hs9pXdyVTzktGx55ovrdW
	 wyVOA8/UtTxvsCWeZc0uH+LcdogjLUkOE6bZIg5pyS372ASVCZX2NfEEYeHu1AIYV9
	 MTHvmZCGhUPl3/YWOIZ/Megi8WfA/tIwiEmIz+zV/O4co2gbiEiysYgg+mlHGk7TiJ
	 cDvc0PNcL2ejw==
Date: Fri, 18 Apr 2025 15:53:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 "Cosmin Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
 <tduszyns@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>,
 "Petre Rodan" <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 5/8] iio: chemical: sps30: use aligned_s64 for timestamp
Message-ID: <20250418155340.6d788efe@jic23-huawei>
In-Reply-To: <20250417183621.00001c67@huawei.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-5-eafac1e22318@baylibre.com>
	<20250417183621.00001c67@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 18:36:21 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu, 17 Apr 2025 11:52:37 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 
> > Follow the pattern of other drivers and use aligned_s64 for the
> > timestamp. This will ensure that the timestamp is correctly aligned on
> > all architectures.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  drivers/iio/chemical/sps30.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> > index 6f4f2ba2c09d5e691df13bc11ca9e3a910d98dc8..a7888146188d09ddbf376b398ee24dab7f0e2611 100644
> > --- a/drivers/iio/chemical/sps30.c
> > +++ b/drivers/iio/chemical/sps30.c
> > @@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
> >  	int ret;
> >  	struct {
> >  		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
> > -		s64 ts;
> > +		aligned_s64 ts;  
> Definitely a bug as we have no idea what is next on the stack
> so fixes tag needed.
Applied with:
Fixes: a5bf6fdd19c3 ("iio:chemical:sps30: Fix timestamp alignment")


> 
> >  	} scan;
> >  
> >  	mutex_lock(&state->lock);
> >   
> 


