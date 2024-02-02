Return-Path: <linux-iio+bounces-2105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28229847BB0
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CDF1F27BC7
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDD9839E8;
	Fri,  2 Feb 2024 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D5Eod6TE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3881752
	for <linux-iio@vger.kernel.org>; Fri,  2 Feb 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909889; cv=none; b=rOTw3oxn7qpfvw305sz6FWI07f9mN339VGKWHnsUZHb6xaT9SoSzyRFAhdl5KWsgT1vgAOw4RqfK8yQA1VaJtxFaD0F9CiJUOtZMUmZFR2l8G7inP19/DL7r3QZViNPLzM2Qidkq40ytWtLLIY1F4yDgaaD+2GHhK4VtCjhI6MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909889; c=relaxed/simple;
	bh=l4yBEaPM2iN7eZW+V6z8vwxu+0SiHLYw7zSuWZAIaaI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebV5ur6DnnSM4/xHcQUzLowC8ThQf+E2HWMTqk83vNBXHDztlpsy9Q0mzG1cPWbroC+w2NPlL/4YkXndEpgRGaqOLAOL7MREEXU65zmmVfaQhREGC4Z10Ok7Lcln4BA5JEZ/9aFTLeY4/XvMOdOlukTaUqLEYDegZm3ZX81wXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D5Eod6TE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d070e2ba0bso26000741fa.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Feb 2024 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706909885; x=1707514685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsomBTujcXZwChvimQjgCPTIq5/QQDBQdY15Zdim2x8=;
        b=D5Eod6TEnTLnHEbeHR1CVGWug9eWQ8M4ky7UFCv6pwEc89UPTHNvInOnWPTELoxO69
         pPpxHsyCZlLx76F/Ok0jyLevnSb0Z49u36zjDeUA3qMYkjYxT55pdCs2NoBOkvms9LWk
         zQGLnwS+2nFOfOxsZiKhEURrpmG65c6XOop/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909885; x=1707514685;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsomBTujcXZwChvimQjgCPTIq5/QQDBQdY15Zdim2x8=;
        b=LVAJE0vj7UNt+3IHPeK77grAyXQ1jTASQ9xwrghlYzhqWHbbPt+LCKNsnO2ywAZrHh
         kHZjSqfb4j+fn2QQ+uAFaKssTliw9JqTtYeqDEKj7oILe/hkcx5CjMUxC1EeV+8h2iMr
         e7ZGV7Hi/35uyL8SrwLMnD1zXCkeQtQxbi5KcIsh6tTZK6jhUPfSwFuhHqRhSn2PAHjA
         Oz1dPRfOyA6OMF28WNx/zFPochIi2w2WcA+MHFUhTDmmALh8gkm7MSKU7O55lak7/B6v
         U30elTcML0vrXSzSBsvN3voRMk2zGmW3yv0skENNFrkrQXyygEGpKI+t2EtSRTEYCja7
         SpFA==
X-Gm-Message-State: AOJu0YxZw6fzG4db2ZMNDkWBYqUK7bjkU4rNTqjTJ+DaHm5SfB4zYzsi
	FM+0jMKQ4tDD2zjTGV/nz0JETxx/5Q36H09xX5dMqz1XYkIxfbNHPLzGCe0yUFEVEZ/S/SZnAAd
	LbPuBHKJllSpApmfE54ZU8cTxvsC9B2WP5j+H
X-Google-Smtp-Source: AGHT+IHvfYyFfJ/R52vEVZbSRZ98QLR/0em/JjYcMxxy+2ZV0LfLeExVSgtkZoBvsF1omKzPLquVoYXeVi2DYmFj9yw=
X-Received: by 2002:a05:651c:b22:b0:2d0:9a74:5e4a with SMTP id
 b34-20020a05651c0b2200b002d09a745e4amr41079ljr.5.1706909884612; Fri, 02 Feb
 2024 13:38:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Feb 2024 15:38:03 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240201-strncpy-drivers-iio-proximity-sx9324-c-v5-1-78dde23553bc@google.com>
References: <20240201-strncpy-drivers-iio-proximity-sx9324-c-v5-1-78dde23553bc@google.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 2 Feb 2024 15:38:03 -0600
Message-ID: <CAE-0n5031k-5Gv+jFuWJekgPfHDw8yjUobqZr6+=UzgOEqOO4w@mail.gmail.com>
Subject: Re: [PATCH v5] iio: sx9324: avoid copying property strings
To: Jonathan Cameron <jic23@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Justin Stitt (2024-02-01 10:55:03)
> We're doing some needless string copies when trying to assign the proper
> `prop` string. We can make `prop` a const char* and simply assign to
> string literals.
>
> For the case where a format string is used, let's extract the parsing
> logic out into sx9324_parse_phase_prop(). We no longer need to create
> copies or allocate new memory.
>
> sx9324_parse_phase_prop() will simply return the default def value if it
> fails.
>
> This also cleans up some deprecated strncpy() uses [1].
>
> Furthermore, let's clean up this code further by removing some unused
> defines:
> |  #define SX9324_PIN_DEF "semtech,ph0-pin"
> |  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
> |  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

