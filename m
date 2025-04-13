Return-Path: <linux-iio+bounces-18066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A4BA87318
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 19:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385A7166360
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F521EE7B1;
	Sun, 13 Apr 2025 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYxYyxCT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844FE1E7C10;
	Sun, 13 Apr 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744566222; cv=none; b=sy7/wzHu6Aoghp4pYwGVnNPq61vIWScnVKQwjpeXfQkS6NdvxJ/lWirK5IBAmHN24oyjRCrBrgSX3dokzQsAWtDu02rfkEgXCqiSWk9tt0U4BnL9iHQgmFgfJPlM/aqk7B/qWtPTH/SdlS+egPoU9K+YKSUWaGSUiukq8JN5DWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744566222; c=relaxed/simple;
	bh=8HBuH+FZfQ0GDiaUaZy+fQQtepBsVB5ioX972Ybr5Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/DOKQH7CKEBDIeynFqEzN8ZFnqQcwqyj3aES5xfX6vUZE1bOyNEKeAwnIVDo2o2eJknRUK6gEkjlTTRGacSqixB2XgsEQ2PXvhjt7Wcx4DJ2d9Ns73LmR/q088cH3msVozwOXdktI0V99JRVs9iqmGo8s02v2j43WOslnbNpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYxYyxCT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3375676b3a.2;
        Sun, 13 Apr 2025 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744566220; x=1745171020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=75igoPrprdjp4EmNwfQjVuaGw65H5Ht3+2Y4xn8eP9c=;
        b=dYxYyxCT0Uze3o746X5b9zerVxTL09vcXGjMcsDrAPyaxYvqf4/YXGOtXPuhYr6sd/
         r5Ii+mv5W7h8xj+shQ1id1RoluyFlIdxH0zTC1QJsBYjlC5sgt8SDKGTyhXrlEh/zHIK
         /FOSzZsBsga+ylGKoa9Yo058FOV3nkDw3lenqDecGqdW/e5xyhhIQWwshdHVuwCXXm9j
         ANj4/0Gf+pJ4FS4LZ4Xza2wwwa1cw+9dKTxrvPHmUYeRKa29bsslZpd5Nc9UDzUwhVzk
         rOflLYMpB6OtfgFkp+HXzgJQX1ECgcATJJFqA3snMguQNwraEgbU/gCbZGt5z1XijL7R
         axDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744566220; x=1745171020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75igoPrprdjp4EmNwfQjVuaGw65H5Ht3+2Y4xn8eP9c=;
        b=wocZ3GIyJteZviv54V0OxZoTIgfxVBqYLnRA0jbZ6Wye5u3Z+Mb6Lh3cEnmsWGDNg3
         WJoPl+5TQX0cwW/fznxcWYVY6cXQi+pFIllcHgpZSfhLCjb93ML/poAmJdSnB/7RLjiJ
         wITgJgIdZc2V3/K6xi75c5cyPxeRsorRFuOH/u121jLVyzw+Fk7vnzuwPJU/geVTMY5q
         +JhRfiufKApWqYz4yDsTcakcxLqRFAv6owUv1SIwLMTe5eETy8fF33tEd83SgISlNMzp
         qG0YIdnluYP1Qz1tIUbqWtsPVIhgDH4yP+Mt8ZIb//U2rkoUWj6CMBujrIa4pBDDLKXO
         NNSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEVrjvpoRCy1j7Vd7uIktpxAuLGVopit3GaWEVh25Dld/xEV5VIAFWV5/VE0hooGxCAYHwCc28QcTqcLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwheKKeVJwCBx1/B43vzoctQlNJ/Qj43jMRrdPzhpefsL8qyfOd
	9YmWv+NqMqii1am53iANfaIgNt4tcSVy7M9SsBMdnSLVnMnUa4C+
X-Gm-Gg: ASbGncsOs7HzVjHSgtpyUHHNynQtW0GERWvvH8S9t4HZuh3MiSURgmnkCBIopZweSbS
	alTrY62pzyIFyeMp+EAtmFEHjpn9ZaU0mg/+zt2VKHlVNKj9U0qJBuRCi5hf74EEfZiX9igXy5A
	+8orPyxDBSZ688WuFpx7+p5WuLCXx7VRelv8h6DCrcRpB8XOUfrBzhDoIOt3fF1tC0P0On4nEak
	XfH4rtAq16nxzyvH9aDmzBZMdkcssBq0392bzO8m48db9M0rAISwxV4JycvpaRpl+a2mdjK3Q8G
	lrpQarUgdvJvvRfX27a6JQhSBzODgrxY8eiCT8USqWJDDQfj
X-Google-Smtp-Source: AGHT+IFRCq7w/UKkvuBmcREfCnZ2HoWtJ8ccIbPQ448PYdZpq5CvKWZ4MF8IyfGGUJr4FDOpapIFAw==
X-Received: by 2002:a05:6a00:3905:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-73bd11a8499mr11089061b3a.2.1744566219547;
        Sun, 13 Apr 2025 10:43:39 -0700 (PDT)
Received: from localhost ([2804:30c:92d:f600:d5e4:543:c403:4767])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd23332d2sm5184931b3a.159.2025.04.13.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:43:38 -0700 (PDT)
Date: Sun, 13 Apr 2025 14:44:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Siddharth Menon <simeddon@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v6] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
Message-ID: <Z_v4EIIy67FfSDWp@debian-BULLSEYE-live-builder-AMD64>
References: <20250413120354.19163-1-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413120354.19163-1-simeddon@gmail.com>

On 04/13, Siddharth Menon wrote:
> Use bitfield and bitmask macros to clearly specify AD9832 SPI
> command fields to make register write code more readable.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Siddharth Menon <simeddon@gmail.com>
> ---
>  The error path for AD9832_FREQ_SYM was not removed as initially
>  suggested by Marcelo, since he changed his mind, considering it
>  would not follow the proposed ABI

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Regards,
Marcelo

