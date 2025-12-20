Return-Path: <linux-iio+bounces-27254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BDDCD27A7
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F284301174B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E89B2D7387;
	Sat, 20 Dec 2025 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNAMbX5A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3547262E
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206453; cv=none; b=ZbHnCl6pNBMQ0fuy/nL3J9arQL51pDWZ2qC/shrb1D3JOJYkL6bTB3J3qBsl7+VAV/GKg3W1lsyUCKRNH26Svnr5K/eBpdzAqpn7Qws5Q0lPzc+W1UHJR63k8TzwFBAd7yAx4VGQHy9qkSP8Y+lqES8AA9H668KVhaFalvAL7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206453; c=relaxed/simple;
	bh=lA0AgYVo4VJ1zieQYmUekCz/QbrYGOw1cTer2l1uJRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEJgCJDdhTrYCcGuRjsKL9w7i+eKtrL4GNvmqxVgH3xP02YtgVFY4jCdxn0klRo+FwHCy4/ZNiU4dST0AO5PRTZQz9W7XBJyZVGtNczdOBB6CO48+e6nTstlAXWDAEkSrRZSVWKKb5kMBlrQKkcOJYxfHzfj9G047SER2XEN9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNAMbX5A; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bddba676613so1718186a12.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766206451; x=1766811251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMFXrY7x6s6vMdaMthcq9rW2uUHtnPnKggV9npnLU+8=;
        b=cNAMbX5Aq7lS6Pt/qLy5PI8YcC8BqPWD7QZJOFJ4LED6PfjCrS8XF+1E8Hy/ajXUP9
         tWQMF4ZECvmXpYSPdWH0/VdNx3kRY8LgLmH+roF5Vo2kWjrlDWnLCiPkeF7LGC3vod38
         IoxHxVgE8HMjFAW9fpXdu2r82GnD0WBwrlX90t4mt5X3rQgQs15t/KAoxMBrHLgbkVwy
         P9dk+R6HSKB0/nXaE/pfo5q5Li59ZtDhFXSFJ7CaeG6Ql82hL7Y4hgFM+WCBXZ4qESGt
         S0c4hqVtKg1a1lvgNoQELJyvwG/0ld7CED76jlgix5HT9RT4DzCH5wpC5jXytRzCZu96
         +umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766206451; x=1766811251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMFXrY7x6s6vMdaMthcq9rW2uUHtnPnKggV9npnLU+8=;
        b=LBE9QJSJUHnqNyehVRRnHvPyKXZ7Mq8aChkimbgmb6uPMqloulXHdzu8oNsZumCdN8
         yluiJvftriAsC7em34u1vba354uyAZBWSBKxyrwMwkiyWhBugFN8TxC80/WBCLrLJhM4
         z7fyePvwEBO0bZK13Is0NnoQJv7QJceJDgD+RuXF/94B4I/P1S24/g1//dX2FBew2xBH
         rG1ehN9lmKasmc/nJjx52hd5oOPxoEOv3izNyS/Nj2dlbzCaxoA2hmFWc3SUmDEmseIG
         +GlaifBrleflnTJdVQgQ0xf8ijYy0GAP5zd2793yB7kQi8MgAaOQBRTGFoB+qHVZTJGN
         Vygg==
X-Forwarded-Encrypted: i=1; AJvYcCWwQZFqxStICegj20aPnEZneSJ/T96KG8G+QrHk76kQkOb7bjOYiMnEmlO0vseLwjcMxlPbUGsClpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxoAoY9MDJVBaQ+D5vzkBWWr0Pz99UdfhLqFUiAccCnTINnQX
	z8cWeRHRYCM/KIWM+p2RhXadVA3wha7G7SF3G4NxKVbL+KlNoksF+OHO
X-Gm-Gg: AY/fxX6jOujeWlXMOUsKCZgTQfz9Dfj8fUi7NeypkRKd/zevnQpAbzGsF/zAc1RPRIZ
	Zjc8Thv/OSjlikPsQNEjI/GfoDj5hb794/FgRVFJiPkh76k0ixlN4onuehIr00aylhcYRMV+4Ln
	P5bTk5tZRpPEDfACg+zOKZhkalPm1l1sO83ZipXq3NoWWdCG/7BWYaUlU7FZ6f7aNmrm/UcumfJ
	vA8pJLiIPfrmgMmV82oMopDNEkUw/2r/9p/ZMY5GXQZF1cmRqSyEaQuZUYGHV0gOQtiVa/OxN3b
	F3C7z6rXqQRrCoF2V2vAhBYj7PjnOfpka/GOb/W4CPz9pxDcWyCjyShJ39dxrad9n9CKq9ufCwv
	AsunOzQX06geqhKVW+EYmX8PawkNkTrhzbwfIwZgT3NMX/03+RRU2DNcvIB0kB6KwchLD73jT3b
	fX6BjKI20+7XYQEfsZXns=
X-Google-Smtp-Source: AGHT+IG4GUpAXhh5GjINeiC9oowR+1WM54RneaWJlRDZ+tq5NQwxqCU41EE2GSYF+2owEGZsu7SNHA==
X-Received: by 2002:a05:7022:4185:b0:11a:2ec0:dd02 with SMTP id a92af1059eb24-121722ebc42mr6715988c88.33.1766206450960;
        Fri, 19 Dec 2025 20:54:10 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm16448108c88.0.2025.12.19.20.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:54:10 -0800 (PST)
Date: Sat, 20 Dec 2025 01:55:50 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/14] iio: pressure: mprls0025pa: cleanup includes and
 forward declarations
Message-ID: <aUYsVl-GeVpABEhu@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-13-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-13-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Remove unused headers and add required headers as needed.
Bring the patches that fix something to the beginning of the series and
bring this one right after the fixes.

> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
...
>  
> diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
> index 2bdffe1e0eb1..ccd252f64351 100644
> --- a/drivers/iio/pressure/mprls0025pa.h
> +++ b/drivers/iio/pressure/mprls0025pa.h
> @@ -12,9 +12,6 @@
>  #define _MPRLS0025PA_H
>  
>  #include <linux/completion.h>
> -#include <linux/delay.h>
> -#include <linux/device.h>
> -#include <linux/stddef.h>
>  #include <linux/types.h>
>  
>  #include <linux/iio/iio.h>
> @@ -23,9 +20,6 @@
>  
>  struct device;
>  
> -struct iio_chan_spec;
> -struct iio_dev;
> -
Also, I'd suggest to not mess with other stuff if this patch is supposedly only
organizing/cleaning up includes.

>  struct mpr_data;
>  struct mpr_ops;

