Return-Path: <linux-iio+bounces-10296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17049931E7
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F1B1C22AA4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958D1DA302;
	Mon,  7 Oct 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFJjcDjJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF311D9323;
	Mon,  7 Oct 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315971; cv=none; b=WhyzvqrWjJUo4iWj7SMyQ6yZhIGxcrqBOEwPovm8Mm7+TGFPQqx5pOJ+UNmyddpNNcL1Jxso9eY54GIP8r5gl9euBSoSJaE1YuZQLhHhX1vsxe2yoLNFpMw6qQPRVTonSSJWfYJxC51wd2+lZt+9zBIIkQoGmqAPoKZ6lK7CO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315971; c=relaxed/simple;
	bh=IPz+aGl2hpLhDFrX5GfJESiSDX1f4cE9gll6GUH7TJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlA6v6UukloKWGf0MO4saVwsrQ7zfJcev5qiqw/f+hWBhbqTNPAzZYN0CzLXKGzbLfACwChLtS+BYHVAfv5bpVZ0Z3+Gax9DXKi1NCB+Y7y02OwUDzQvb90Wh5t7AjLwvoS5at6r9Ay2/qC7bRVgVSA2dPms5qJOItRj+w5HY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFJjcDjJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso3162060f8f.2;
        Mon, 07 Oct 2024 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315968; x=1728920768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6dprjm0PLZjMBeHgDbl3Q6+Sj+1Lh0wF19FbiiI9Hs=;
        b=OFJjcDjJSg7zcYMMaOZXiQxxWNFtOXMKsVXvzkwLk8LavbSlP7jt57ezv4mpSf8mlr
         J5QyhRdjg4tkHYbL9EvqqDSog9oJPyyyKILFg7t+fXDUSHtcv5RhDRD7qSKiyO2UTS6n
         ol9UV6GUa/nEcNH34RUJyjVqgHeu/UAE8r6BkP0iAloSi7PZvxND51g9Naw2kVbqVjKR
         TO6BW7+AyPrIVSL2QTOTHYarf6PboU1rhVvZMgvsmIpw1M5M1grNG0HbkN3VCgfAEHUm
         8QpNJChhBCTgZQJRLk9vMx7KkcktvRbu9yXYPLqU/1tkTOBa6AMidu0GcRZMAmrA1TjG
         EA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315968; x=1728920768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6dprjm0PLZjMBeHgDbl3Q6+Sj+1Lh0wF19FbiiI9Hs=;
        b=wbcL0v9hchiMGFVF6+PJDbtzeIBZNlWIhM/hAUOgIVqANpA2MHlR0yPkx+T5zciOWB
         fJlspNFhn3/r64kEqOT7VAgnBNcdVskLs0QQzco2L0R5Z6t8P3gifm8k0D5swPXPb21B
         IHWfo5vPDjboJ8W59mMflqiUymPNLny7TZ1FKWdCEs00AthpcJouKtp38hNmQ8fi8j0p
         aLyQ/3CWYEo3WMvy1TaWc1jUaWQqrx05LRJPgOR/hwHQJbsKOAa9bboPDqvsP+mbh5z+
         zxKd8BF8FRl27V1P97OANhS3OsdZ3xdu/lIGcUkmFHJN/A9CMxY5FKahnpwmdDanJw8j
         b8ww==
X-Forwarded-Encrypted: i=1; AJvYcCUj8DDC7pd3Wx3/+OpbcQv0nXGTMMrhncK3F90uW87/umX0bdPbqFer+xbbSL2+XuHwuSCTfIokXEOJy0wS@vger.kernel.org, AJvYcCWyefNgs1FAUV7vNiiBovlTfUR3Tl2cmKl2tzdvXXc3NCII7nDxCMiRSFdqprRpfP8XxTwDOvL+Xus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOqtKi8VnmOU9i3VQRABAvbV1kcsOJv+GL3YIZiKlWI3o2VwQ
	dfZ0FK+88pi/O5r92XexkEV2oLqdh56G44YG6aeTO0lupcW4NFFu
X-Google-Smtp-Source: AGHT+IF+8sfGIn0BZv8JEm8l7fv06gDZuaryeZmXzbmOn6DC8csfkugDv/BvinOfUhgQEn85h8XL9g==
X-Received: by 2002:a5d:63cc:0:b0:374:c31e:9721 with SMTP id ffacd0b85a97d-37d0e7d40aemr7238976f8f.42.1728315968206;
        Mon, 07 Oct 2024 08:46:08 -0700 (PDT)
Received: from redaops ([146.70.124.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e89b42sm77975205e9.13.2024.10.07.08.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:46:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 18:46:05 +0300
From: Tudor Gheorghiu <tudor.reda@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH] staging: iio: frequency: rename macros
Message-ID: <ZwQCPY7tmMg7ciVZ@redaops>
References: <20241001202430.15874-2-tudor.reda@gmail.com>
 <20241001225426.wUBOFdMi@linutronix.de>
 <Zvy0qyQJP1S17SFv@redaops>
 <20241006122712.2cff065c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006122712.2cff065c@jic23-huawei>

On Sun, Oct 06, 2024 at 12:27:12PM +0100, Jonathan Cameron wrote:

> 
> Hmm. If you really want to clean this up, then these macros shouldn't
> exist at all.  They are legacy of ancient IIO code style and some slightly
> ropey code even then (which is why it's in staging!)
> 
> Right option is to use the read_raw callbacks in conjunction with the
> info_mask_* bitmaps that indicate which attributes the IIO core should create.
> There are some corners in here such as PHASESYMBOL for which we've
> never fixed on an ABI and that might need custom attributes, but even
> then these macros probably wouldn't be involved.
> 

Hi Jonathan!
Thank you so much for your input!

I understand, so this is not as simple as just renaming the macros,
there is actually a lot more to modify in order to make this driver up
to date with modern standards. I will leave this for the original driver
developers.

> So I'd don't mind 'fixing' checkpatch or the code, but I'd
> rather we fixed the drivers up properly.

As for this, it is somewhat unrelated to the actual driver (I didn't
even consider this initially). That is why I submitted a different patch:

https://lore.kernel.org/all/20241002133418.7924-2-tudor.reda@gmail.com/

Thanks again,
Tudor

