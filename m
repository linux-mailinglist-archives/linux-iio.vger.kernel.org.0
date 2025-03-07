Return-Path: <linux-iio+bounces-16509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E77A55E4A
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 04:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A505E3AF7DC
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 03:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD831494C2;
	Fri,  7 Mar 2025 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDYWWlNq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2ADDC5;
	Fri,  7 Mar 2025 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318300; cv=none; b=DjH+qHMBHCvpZmB6Gyfrf9PHmlYIANoz5g0Q0vL4t7jakvP5dp9LM0a9Lf9IriDNuygtUIJUzNLGPSGtRSGKO1lQ0U945PRKRnYStwKQKWuYign0IQrdbupdK83Oc6/CwkQOEeIUQbQ3wQkFMFD2D1tTg2o0jRZ6XWjji6Z2t3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318300; c=relaxed/simple;
	bh=gCOOcyBomA8ym/MPB9dZ8uybUtzLM0QMJZ7UNpi5h38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmBdQ522RlKwI8kJ78m/lGOgFhUwBQ0LFiLTy8Wq1NivnA4WbqLI7l+/J6MskBjRGIO7E2SwzP48asC0DJMpBHC5OYqjzUKjO9VklXqLXm1agfYTvI4te0RiPco1SZsXbxAJh7GzLZrKqgniUaEpZvLWpDAwlFDAisJt2ifOgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDYWWlNq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so20172255ad.3;
        Thu, 06 Mar 2025 19:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741318298; x=1741923098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=POmXH3RB5AOdcM4iy/V5RM3jxDeeDKhoQuC/nTf0CE8=;
        b=bDYWWlNq+OENoc/6JKnjsCaD+RL7a3lGRL5Nvbe9B7CWU1guT3bFX4jbY22KQlQ1xK
         jE4CFUk4+fieCPEQ/apb1t7ucfMWCLuLGHNV/abA6tzxiszamO7B7BqRdfVDYP654JJ5
         US38J1s7t3yqgsBajMT9qdi/+Uiq6l1TYloxJ/CHNeOhJy+4siFppsnJf8oYubsqy5Mq
         iMnq1W5C3VQ2U96bE5Krv7WfUhEfQwcq2zRtqDteS1sk2lV0uSPYY9R/jSqlUm9JRmmR
         NDakgQXz4mzKW/B2wS+z5NstyllHGime6pHhno6cQcgX78a+8b+nWPbts28+upZ2OvcX
         RB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741318298; x=1741923098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POmXH3RB5AOdcM4iy/V5RM3jxDeeDKhoQuC/nTf0CE8=;
        b=HMhJgHoJ4II+7t23fiGHz4cQdc25VwxqIETdtx4wj2ZmZLHaUlKoOP4XzDW5v9UeBj
         RIQcro7+mHnSRx7DowiRWc2Vil8ctiaUgdkLCabVnKBPwIeIkPqzOvrBZ4B9dtxqr+v+
         5EZus5oB4l0ikgbnDCU1bdanghYAfe0CdaA48QyVNMjAyBZ/IEZOG9Z2SpGJcTtfTG0C
         lIx8oFSdQA/+SF9CbvO6ZY7im+xdh0TbgdbVih7C4FilaGkSSvELtz2R0YUWshkKTMfe
         xnzNBg5SE6TzBvcUkAJqVRpT1jCqeuk90vEi3AbgGbJCm5OFeEStBzkov+J0Fmr2K2rx
         aM4A==
X-Forwarded-Encrypted: i=1; AJvYcCUs60QRQg1cceMl5J1EKcXuL7hlZg2VzrtRsH8V4xJSbBQe0xoYxXn8m4we19vB6rAxHqf1pLYPucQh/kt6@vger.kernel.org, AJvYcCV5798TPgj9GhaBKq8x6wrjMyEU8uHFzjA62r0QNQtKSV3a1NECbnHJDCBKUm2eJAaC/SvU0XvEHNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKnvCZ1PLOJK5kaf/IX6qbdhAurRo7jtzW886R65YNWJu8yy/
	wbk6jYw6sx02D28wJIrY6KmNwqIieJubxC/fBmFAqc+KB6qI/nqbBLZ1OUihUQ0=
X-Gm-Gg: ASbGncuyLBSEZ1dTapMJfETfLZcd+osiO1NiGodadScTtXocQZ4f168FXUhMDHyjh63
	SUvfdm5qKGqRWw+JQ3ufCoPjuOrT5TDwmRXnjfAAbaBL7Vr9eMo3tiyscr9HjcEfsYnqv0TNHeN
	Ky8BSo53bwgW+Nk8D8TzB/id7xM1ux/zJai6GTKoUNCCKKMJWdRNFiQxYqhUfvBT42q+ag4k6FL
	C+w6oFI969VCCvqP/AosgA8VqvtQFQ8kYwpG/88FSH2AYG4BqLAT0SIgYetlClk0pcZxOQAqAO0
	xSkj24KIKIVtZZZhPpYcfQhpHZeGXm4QvNmKIoxoba8tgxEadKj93zk=
X-Google-Smtp-Source: AGHT+IGkebL+fF1LPcEVxoOTh8Md9lfPjHNCFJiq4bU7ai9wRrrBoKSjgRruULMi73fEeTWoN6quYQ==
X-Received: by 2002:a17:902:e5d2:b0:224:160d:3f5b with SMTP id d9443c01a7336-22428c1169cmr29142615ad.49.1741318298523;
        Thu, 06 Mar 2025 19:31:38 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109fee78sm20022575ad.105.2025.03.06.19.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:31:37 -0800 (PST)
Date: Fri, 7 Mar 2025 00:32:30 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Saalim Quadri <danascape@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [RFC]: Getting ADIS16203 out of staging
Message-ID: <Z8pozuvS1a3sa039@debian-BULLSEYE-live-builder-AMD64>
References: <20250306002645.1555569-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306002645.1555569-1-danascape@gmail.com>

Hi Saalim,

On 03/06, Saalim Quadri wrote:
> ADIS16203 and ADIS16201 are very similar in functionality whilst the
> major difference between the accuracy in ADIS16201, I wonder if they
> can be merged together into single driver, whilst also implementing
> platform_device support in them.
> 
From quick datasheet comparison, yes, I think the drivers could be merged.

> I want to work on this, provided some opinions for me to work with
> or to have a separate driver for both of them.

I often look at two things when assessing if two or more devices can be
supported by the same driver, the protocol and internal register structure. For
IIO devices, the protocol is usually I2C or SPI. Though, even between devices of
same protocol, there may be differences on how the data is structured in
read/write commands. Also, if internal registers have very different addresses
or meanings, it makes it harder to reuse code because the configuration
procedure for each distinct design/device will tend to require specific
handling.

That said, ADIS16201 and ADIS16203 SPI read/write commands seem to be the same,
and ADIS16203 registers seem to be a subset of ADIS16201's. That's why I think
it may be worth merging the drivers. I didn't read the datasheets thoroughly,
though.

> 
> I see that there has been some discussion regarding the same at [1].
> 
> [1]: https://lore.kernel.org/linux-iio/20230124094450.0000272b@Huawei.com

Git tends to rename/move files when we move a file from one directory to another.
IIRC, Jonathan prefers the drivers to be completely removed from staging to then
be added under iio directory to sort of make it clearer that something is
being added to official (not staging) IIO drivers. To accomplish that, we
use --no-renames flag (e.g. git format-patch --no-renames ...).

> 
> Sincerely,
> Saalim Quadri
> 

