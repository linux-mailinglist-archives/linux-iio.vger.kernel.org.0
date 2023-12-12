Return-Path: <linux-iio+bounces-871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8C080F947
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 22:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF41B20EC3
	for <lists+linux-iio@lfdr.de>; Tue, 12 Dec 2023 21:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A46412D;
	Tue, 12 Dec 2023 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUf5Hivl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC72BC
	for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 13:26:16 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6d099d316a8so2199108b3a.0
        for <linux-iio@vger.kernel.org>; Tue, 12 Dec 2023 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702416376; x=1703021176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5PlYZzo9vfTv/yv9EMUjQKbKWWq7A3gpV1Plw7Ax/Y=;
        b=KUf5HivlYL4ctCdp+SW+aRt+SMv/QY70kRXFLFAk41qCRZyj208eQV+tNJTJXFf44N
         UwWxEFLGWu1UskPYvENoFXxrz2T94Xs/qjlrTN68HVOAKnDaz0SX6oEPcgQD/jVoJnFc
         v+EfcOAyxQyAUYX/vnRufNDnMY3MVfHf91cq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702416376; x=1703021176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5PlYZzo9vfTv/yv9EMUjQKbKWWq7A3gpV1Plw7Ax/Y=;
        b=VpDmYK2KNStwEClPPk8UWCtMSi05EADMuHzREBvJdY8th8NV+cnCF7d1+cFksee0k8
         v3VpM7hN1B/Lub8unRgU3EKM6gs6JZMGXVO0r9H3LWYHU6Pg7nQWhaZTS/oWG/nR79Bg
         IacvY+XVfyl42okU1u4eWyCbUWYfQtl5KJpMH/UYz1BNiufxl8VwwAoMBdaQLXRo03MK
         fEXXI1WUb+jjC+YlmYYNSzPOJ7dee9M4TXzkBg8toad4Gi5fgzsSe638iRZIcV/H+6cj
         IVIwWCPeJKYIQjB6nM5Ne0xE6ozJh7WQcEdlAq2fxmLtoqYjiq8wdQP/TeDhDyYUVb13
         Ry8Q==
X-Gm-Message-State: AOJu0Yy/y+DyVXEEh5921a6sxSnH8nnnR5xj96Qd9tKEM1zPqHQAONUb
	R27xPX5ypApPqs8zj4h4BZJA98Yve+mFF+sZY78=
X-Google-Smtp-Source: AGHT+IECqwmYAGxNju9XRpHNOvS5qlW6o+Z0/xSSH+d6V94jzZqBhGBRMbJv+vZJSerO98ZHSCjsqQ==
X-Received: by 2002:a05:6a00:4601:b0:6cd:f91e:dfe4 with SMTP id ko1-20020a056a00460100b006cdf91edfe4mr6874221pfb.2.1702416375774;
        Tue, 12 Dec 2023 13:26:15 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a0010cc00b006ce61c9495fsm8571312pfu.206.2023.12.12.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 13:26:15 -0800 (PST)
Date: Tue, 12 Dec 2023 13:26:14 -0800
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] iio: sx9324: avoid copying property strings
Message-ID: <202312121325.E29472E0C0@keescook>
References: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com>

On Tue, Dec 12, 2023 at 12:42:52AM +0000, Justin Stitt wrote:
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
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, I like this approach. Totally removes the string copying and
creates a helper that does the "heavy lifting". :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

