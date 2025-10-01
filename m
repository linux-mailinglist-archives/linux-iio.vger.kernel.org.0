Return-Path: <linux-iio+bounces-24640-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDBFBB17C1
	for <lists+linux-iio@lfdr.de>; Wed, 01 Oct 2025 20:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA7C3C0A4C
	for <lists+linux-iio@lfdr.de>; Wed,  1 Oct 2025 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FEB2D3EDB;
	Wed,  1 Oct 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4eNu9nu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B9E29E0E6
	for <linux-iio@vger.kernel.org>; Wed,  1 Oct 2025 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343157; cv=none; b=Dj5coL5o/fyLzEIwYXhF7HF2zfZr/iA4tbI4h9mPJRuBcarT76pOebZaOPp0qIUhS5YPIRHVcpr0dugFC0dKvrjwBiyEs1IiBYVQh2nwFYK9+u24XWpOjw68CdX6ton6+Xyp45vFrJNW6IaDj8mssEnwKgM+OOf5ukq8Sl2RbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343157; c=relaxed/simple;
	bh=ymIIKugm8dSELizjkSSCIK6f4FNGs2xxjhEosg+XKAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLjTCKwusPG6gDXD8ST7fXfdGjGpWthYTwZTTcaaRlPpnaBuRJi/lkEUE6BFqofn6+2BA6UA1bWoND2dII3ncFA9C7Mfjp+nKlX+cdckqNRx0GUwnZ+JjvmdSochO1Q0QpDsntpeL6Hecsqvb11/0iHB3Ac/WwHxYYG3qE+nQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4eNu9nu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63667e8069aso434642a12.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Oct 2025 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759343154; x=1759947954; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gy2/5v+aVMufW/rwxUs7mjSazEFFKsyqBqWXuO9kk7M=;
        b=a4eNu9nudOssKQXhRzYn9FahWWOo6CHJiqrnr992AkNgcFeMsEp4t1pkQaTe+S53/3
         Rso/jdBasvIcxllwcII1oX5DgEvLyo3hyVkXS2g4mlHdYTfDUp7+tw9DNxXDkS8EuuDk
         tGKE3b30BoenzGbzEAeNgIawmyFEW3EgAnBko+ZPmMFzTQtcDDKKANuYmQ5VbeCUoRWR
         zpOlOUDXSXw+yv5haEiAf5JjyQQ5Qd3qeqPny9d75JjyU+a+HhgOJjndtXD1I5MlKcSL
         0UEP6KDHOeHhxgdGODRgFzq/CED2qzLkkoaqxLNCEW9NB7THbcg0qOsG5h28vZUUDVeY
         LOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343154; x=1759947954;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gy2/5v+aVMufW/rwxUs7mjSazEFFKsyqBqWXuO9kk7M=;
        b=ZGslAm4ejvlOuftytihRW9rKrJNj5vnThKcs61PO8BeleIx7yRMQqsWpyL/q0pm/4g
         h/XKHBt++6N7IH6CX+BSX+HZzuc9UkW2CfWlvr5eMqjP0RxlvhbTTOPl9/LLkx2Apwkq
         /ipd6uFrkNhpP8kYpDGiAPbZTdu9IHFAjlCcPil7Fgf2FjXVE0iXyAGZvZ/CRvg2PWRm
         lGysTSmgaIOKOLGpwgLfGZX5SZqwJWHCKHzhaG+hFwNL24j7oCruxOlm7GIyktJo/J8t
         ODx+pI1fpACdDJp1bXHbaHRYwGRM9XbFKncxofgRD2Pbs1LeuECFlDfBzjtp8Ud8o1qX
         rlXg==
X-Forwarded-Encrypted: i=1; AJvYcCUX+NPJzJUDTFBFBj/AtLkfg9psFWy01IW4k/griCQm6rqxrwyP584bB79orRY4t+6Y4TSNp8APcUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+dyepvIYe4nDX/+5Aau8NtYpNJpDfI/jTgKWuyQrQoxg7TE3
	9sTcXytNoUNSHrF9w2aHgz3ZnrBbuRJQENE1/Esmxmf3PZYx6I9rLLbI
X-Gm-Gg: ASbGncsJxED6kRBYkRjVuyb/GMy+XJc+vJHZpnCNJBfxIw7qWaqy0v4ySSdmRk2LT2Y
	qsWyo6LZNLXXg0NPb01ivqxz1VVIhFbijWoe//7+tXZOamsIN+jd+8atf5uT7xQY/bvvfLHu6QH
	4MGMgTTm/hsbAfvDhwCHxsh8YO08uX7z7hWJuL4Mi08/8pxDr3AgeY3upz1yALUIqVKs1NE4rm+
	4VV7L7ew7SP6PDfOQwBP4ZAQSYDMLTC3l1yQzEyl8LteBDe0XVEPvwQv2ZwaCQfjR4EKjSNhsps
	RCySTFNYCFF+09l7qYon4M6D8cWbuijWorkNuD1YkiTLZnfAt7zOecCiOiGRiOJERm7T/MMwgdB
	jAV40riqJCmhKNqvz7a+37o+YWPLhv9siOkQCpBGY62Jo65eREveqmqsZFooEufGFIbqgNd36zv
	43KxGR
X-Google-Smtp-Source: AGHT+IFYS1wpjnOHA/UgM1tYK8yjpc9MxEefzrC47WYXYDv2qa+LqLdGjB8G0GOUqesJP0bsWnW/XQ==
X-Received: by 2002:a17:907:6ea0:b0:b46:bd57:140e with SMTP id a640c23a62f3a-b46ea228a9emr408417066b.61.1759343154059;
        Wed, 01 Oct 2025 11:25:54 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a7c660sm20827466b.22.2025.10.01.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:25:53 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 49143BE2DE0; Wed, 01 Oct 2025 20:25:52 +0200 (CEST)
Date: Wed, 1 Oct 2025 20:25:52 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Hans de Goede <hansg@kernel.org>,
	Marek Vasut <marek.vasut+bmc150@mailbox.org>,
	linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Julien Stephan <jstephan@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if no
 IRQ connected
Message-ID: <aN1yMAeB6oDIp6k2@eldamar.lan>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
 <79946c40-e2ce-4fbc-a6b2-b37f6fd69d1d@kernel.org>
 <6oyvsvp2erynwu3evulbg6gtdryabeuoo46qzku2grxg3jxptf@jszhnvmj2ffc>
 <30fb5c19-d4e5-4740-afc4-c15b256a99e0@mailbox.org>
 <aID9byW4WOsUExHR@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aID9byW4WOsUExHR@smile.fi.intel.com>

Hi,

On Wed, Jul 23, 2025 at 06:19:11PM +0300, Andy Shevchenko wrote:
> On Tue, Jul 22, 2025 at 04:48:45PM +0200, Marek Vasut wrote:
> > On 7/22/25 10:55 AM, Uwe Kleine-König wrote:
> > > On Mon, Jun 16, 2025 at 02:42:54PM +0200, Hans de Goede wrote:
> 
> ...
> 
> > > I don't have a system that triggers the problem, but there is
> > > https://bugs.debian.org/1106411 which I guess is the same problem.
> > 
> > I think the debian person is on CC here already.
> 
> You can even Cc that bug report, messages will be added to it.

I have bit lost the overview: Was there any conclusion on the right
patch to address this issue?

For context: In Debian we got a couple of reports more to the original
one above, https://bugs.debian.org/1102522 and
https://bugs.debian.org/1112643 , so we defintively would be
interested to se the issue addressed.

Happy as well to help affected user to test a proposed patch if
needed, just let me know.

Regards,
Salvatore

