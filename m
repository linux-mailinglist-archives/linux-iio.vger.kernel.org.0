Return-Path: <linux-iio+bounces-13055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2389E2E2E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BB1163E9C
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3320898C;
	Tue,  3 Dec 2024 21:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY3Ya0eZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A72205AA9;
	Tue,  3 Dec 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261898; cv=none; b=ub3Vv334Rju0d9OTm/dY/010u0/TCP8iaF9bX0UxPn+XCNFI7WxcwhcDNkYM2516JrPa29ggf+bWc/gISjXWn25fGAPYWLTcn7b0SZqnT+V0K/WJ8O83KajOUmu9TrdmCHjT7qJdW1RMz8/uSySK5EBjJhM4/bqmaZXtFK8JHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261898; c=relaxed/simple;
	bh=l03a30oLSQSPguXncQBQuphNBZWYsKqZgJCGJsnRpWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYvtE41nchVx7IP81hzMI8F1uHJGSA790ZlSOMwi+gDl944MeaBTBjhSigJvpR9z6iQnRy+KwcbNIY9U+JGfu7gezd1lapFnTUZtVwwr6VrvaiHpHbou4op1RM+GnVia0Q3Srx4vuBkFMnq2wHsYWjSOj1z7HPp2zv/nZUdy5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY3Ya0eZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385de59c1a0so4514473f8f.2;
        Tue, 03 Dec 2024 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733261895; x=1733866695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FGHzM7J3OqvAreJZS1EIJ3jxTVqZr7bzpMiim9rHNY=;
        b=BY3Ya0eZIY0tjhmKmAFAaACZwB6oOxb3T9YGBIT8UGFPnUlKaeSFOYorZnejF33oUm
         jVLO9secg4fx3S+297fFy5LLkw3PsxSXM0ebtZt2yaQCeSdGXKjQKOCIWsxSgSkIm30F
         Mee81BAyfiJhCvOgn9sOPbV0hS2IRieONPAwmKZLpPn0K25b+uT/3Y+yquSPzH3oB/AO
         M6rXH3nd7vUJrk9tLwutcp6ayctDp1YUw92rJXx1WV/HQcDyHzhllXO548v4h8jXVOFI
         cv6j/gRT8ddLVVquKn2fvSFPEOG5qevWMPKqa5/dKqW3Z/ctZ4Bbz23tPjVifGs+s5YG
         PKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261895; x=1733866695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FGHzM7J3OqvAreJZS1EIJ3jxTVqZr7bzpMiim9rHNY=;
        b=XBxW6sZrQBGKOikRg/uvWViESAnTLof6g9wobJxcUld2x55r0W1UgHz6n8Q/vZQ0bg
         +bRRtSo5JIWt6TF3PEJy/N1UGevlpq/e7eosiGIq1RKiYfyazagh2QeVPe5bH0YizKxu
         J12P2zOii7sCu6ae5Skw+nABvMqxs47QF/x8W1i0EfHa/8X928dY/sLM/4I4hZbpZx5G
         TPM9VfaQFgEl4wsLX2wyIGjyXCfzxaenu18tTGU2yWYpkRkC5Xb/5l78gF1OdX7qek8O
         8VfcqGNZzCFJCeFyEQQIhYf1ZY8+E1i7WYQVgTI2CfaJFxXzJYKif8j26cJrW0JdNhM6
         /uYA==
X-Forwarded-Encrypted: i=1; AJvYcCUJXiPaoF+RGU6dY0/cqy1k5XE0NOZvt5QBfN+8N00RiSJtgo91wDJh/QecpScchvcYRqkD8fkTkrE=@vger.kernel.org, AJvYcCVaFJgy5UFOIsi70qStrG0ADZh4vituuIjPUE6BWRWHaNmbmZKrKgzNcfQRGI3cd8NMMiAsNnIoRw0d0fy/@vger.kernel.org
X-Gm-Message-State: AOJu0YyhZ57W2MRUdKc79TJirARAf7zipvhN58dsbdwOOrW8dAc839Rq
	eHLJRU/omzjrhPYztLPtwmqthi9IEz8wVWy4Y0XoeV4UMKM207g3
X-Gm-Gg: ASbGncvmBp90JXC8Ub/JrgPrT0BXG4y659cLO97/qd4YNKqDWP3j3O8WCQ6neEJYKDe
	nAf2K9DKCVPL5iPgmpsoMRnaoANATTkgbwCE8LPX8z9ZaOQVIB/pgkEszKjDkmhpBIC8s5uAXDJ
	OgoZbMpHWI0P3mVsIIW9ohAHtZObIrD+HgRfOWZBuIoIpfJgx9nwMSWc5xFGrXtN7fEL8/s9iH0
	kPvuN8KfxVP5fSxFyHisPUWDIBuV6UVo+jMJ8OS6iURGi8l3MQJZXBFw7wR
X-Google-Smtp-Source: AGHT+IHL4wO3JlYTbKLCNKO+w6R37VMh8CYOEEr1VcKlglNKl05nYfs4II9OTn1WL0oy9csmVypfnA==
X-Received: by 2002:a5d:64ce:0:b0:385:f220:f779 with SMTP id ffacd0b85a97d-385fd4364bcmr3386171f8f.49.1733261894586;
        Tue, 03 Dec 2024 13:38:14 -0800 (PST)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:56d9:cf1e:faf4:54e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e13e8eadsm12366715f8f.28.2024.12.03.13.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 13:38:14 -0800 (PST)
Date: Tue, 3 Dec 2024 22:38:12 +0100
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, krzysztof.kozlowski@linaro.org, nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com, abhashkumarjha123@gmail.com,
	jstephan@baylibre.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jack Andersen <jackoalan@gmail.com>
Subject: Re: [PATCH RFC 3/6] iio: adc: dln2-adc: make use of
 iio_is_soft_ts_enabled()
Message-ID: <Z096RGnVRUQo-Wgn@vamoirid-laptop>
References: <20241130002710.18615-1-vassilisamir@gmail.com>
 <20241130002710.18615-4-vassilisamir@gmail.com>
 <20241130140255.70b4b68b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130140255.70b4b68b@jic23-huawei>

On Sat, Nov 30, 2024 at 02:02:55PM +0000, Jonathan Cameron wrote:
> On Sat, 30 Nov 2024 01:27:07 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Use the iio_is_soft_ts_enabled() accessor to access the value of the
> > scan_timestamp. This way, it can be marked as __private when there
> > are no direct accessors of it.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> The original code looks to me like a micro optimization that we should
> consider dropping to reduce complexity.  It is only used to zero a hole
> in a structure conditionally if the timestamp is enabled.
> 
> Better I think to just drop all the ts_pad_offset etc stuff in favour of
> just zeroing the whole of the data structure in dln2_adc_trigger_h()
> whether or not the timestamp is enabled.
> 
> My guess is that on a reasonably performance CPU the occasional cost
> of a branch miss prediction will outweigh zeroing a fairly small structure
> anyway.
> 
> +CC Jack who wrote this driver.
> 
> Jonathan
> 
> 

Hi Jonathan,

Thanks for the review once again! It looks like it should be fairly
straightforward to drop the zeroing of the ts_pad_{offset/length} so
indeed, if Jack doesn't have anything strong against it I could move
forward and send a v2.

Cheers,
Vasilis

> > ---
> >  drivers/iio/adc/dln2-adc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> > index 30328626d9be..f9cf132c41e6 100644
> > --- a/drivers/iio/adc/dln2-adc.c
> > +++ b/drivers/iio/adc/dln2-adc.c
> > @@ -128,7 +128,7 @@ static void dln2_adc_update_demux(struct dln2_adc *dln2)
> >  		in_loc += 2;
> >  	}
> >  
> > -	if (indio_dev->scan_timestamp) {
> > +	if (iio_is_soft_ts_enabled(indio_dev)) {
> >  		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
> >  
> >  		dln2->ts_pad_offset = out_loc;
> 

