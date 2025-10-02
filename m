Return-Path: <linux-iio+bounces-24681-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41C3BB57D8
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 23:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B56819E7556
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B55727A127;
	Thu,  2 Oct 2025 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqbNY72q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5D1B4153
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 21:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441084; cv=none; b=LPoD7WvQgtgwadiekrDktlAN3snPiEHH3GDWSB6bIG3kWN/5FtYRIJtQrapT6AvR83nprBhHlgUt+mKbfcGAwBo1RPEvz9rF2/kJ2EKZtl2sDw9/b2Xlw9JcKQFSQxMMB+jAd0LHrywJiefkUUUif/NH1T6xxaW+bi8JSc4mCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441084; c=relaxed/simple;
	bh=Wa3MaIt2OTfDMAacePpuDpp+xPuK/PWuzyclDSFj+t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSU3jHjBmQqzjJIoiSZ5AyUKab7+dsNBCT8BvGfWl/X+t1T3vIgvbbp/d3QyFxOiCguGdsa9fft7SKJ03rNFeBViKtHh7G47sk9liTyKORhnoOdYGuN4l6iZQYTdYKOqEv2jies2xUizm87biR73n2OV99JeRWzSjAlWdEoLAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqbNY72q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b593def09e3so1113490a12.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441080; x=1760045880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
        b=CqbNY72qE2w3zNKipvYfu4gbH+WsSVU0jPrnZ7lPyqJ5sEUbMA+S93FfUSPW/wGrgv
         yHd/PvzWVwexTYq+yTJCcZLyufzOK/3LpjIu3HluIhs9HVn2wLZkleBCIQXsNveaSfhK
         QV9497y9rCsWmZMK3VBIxytH6DnHYYsMq0BHxDl9PIbRCKbuhBI5VJZAXv8BpYh3n705
         LzgYyJp6FQWB3xCehIly9OycrMpd5U+68M0jIn8bJeEG+5HP7sgvdipBem1PLxFf97U4
         LAqCY+mHuUQEoK7dajhok0XHX0882CogkILYiDb6gXlAhkgWeBmqQNcfYGvZv0udvi0t
         +yCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441080; x=1760045880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
        b=TE2NnMWxTZ9+Aj3iR+klalZhFUU5wkwh2zbe4IRpQygmOKZ+IXsed3UfneJPb3PzAE
         iTPDViOyj53OwRfoXVKOd/QkSzgQkMKT1EFqhen5Fx0nQHYtJSvtqUGbltU74AU+8NRO
         M3jIYL7TFGZWUlzKvsWaEk3RAt9x5PjBWn8kgmTeFsbX3g49JUHJiNDCPiyOoBImOVFH
         OrcpKlJhBp5GRDETaCsWuQXL6JJ3ULv+mZcgwNNq4lSglPGxTbsySIRWkuNJICsLvkBq
         iAV/LyEGlWIyqY8nEfZwBrZ8TFlSxjZn3Uq0If/q6/8fwUmX0+8TEVAHkiRmEAd0QV+r
         8BgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKLbI7q4nsattX7WrePVGpy+gkbLzBUYFspfKo1yM9I1SNDU1LckwpMz0gRAbE+WL+2DIfnEiPteo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZdU9oG5HyDj9nhYGzSoLpZHC59gys7hIQh3+35wLH+BO2qCb
	HbOgrAhmYY/9348Ue0KqKTwJzNzYPcF21xRU2e/58B1zLLN+RyVk9znw
X-Gm-Gg: ASbGnctduyOqgVn7mnjTEM3x+j02+jLvJRq8HMNcaJ1FJTk2vs+KcMC6VUQClW5M+CF
	FQpa1VA9p/szqN5tP7FrH4REYMEVlsnbcgwo1zl7TZhr1C82iyWnzYsVnggOQhcjYW0W0Uov2Hj
	AYyMPjVhA5TqltpDp7HV9RkpFN82up++YV0GsHwY7CAzRxS3gDCkjK7ZNxuvKx6C6A8vfrDjaEN
	BnaF0acXNQU01GXdk2nEl+K9wJAi5/2zs1TmaxIlNpUKDiHL/6DsiyQ57AtttZVwNgjRrp1HmMT
	4icC2z1dLf9lprxbVDaSE9VwJC7h3t4rCY37nh7mIqgKMOMlLEwbgehzd/gD1ECbJXAkaUaqjl0
	BPQMg+Hw0ovxNk4xJ8k6ZIUuUYWZVHmC4KVqswtSf9V4vibqZdIWMh/tSC/Q=
X-Google-Smtp-Source: AGHT+IGfpeSt72PLiRG8302u7jW0eS5cM/tPuBTjoCfYGBR7WBrL3m9GghHnqqRwzstji5FK0/L81g==
X-Received: by 2002:a17:903:2ad0:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-28e9a6fdf1bmr8314995ad.56.1759441080436;
        Thu, 02 Oct 2025 14:38:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d122d96sm30394595ad.32.2025.10.02.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:37:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:37:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
	chanh@os.amperecomputing.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785
 compatibles to max31790 document
Message-ID: <4b617318-f76e-47b0-9744-6a79803a149c@roeck-us.net>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-5-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001144441.310950-5-eajames@linux.ibm.com>

On Wed, Oct 01, 2025 at 09:44:38AM -0500, Eddie James wrote:
> The binding for the max31785 is the same as the max31790, so just add
> some compatible strings for the max31785 chip.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

