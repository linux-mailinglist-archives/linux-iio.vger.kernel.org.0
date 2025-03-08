Return-Path: <linux-iio+bounces-16566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E15A57B90
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A121891184
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC81DE3DF;
	Sat,  8 Mar 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUk25tfE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D336919DF9A;
	Sat,  8 Mar 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447616; cv=none; b=Rd3hkNjNt+gr/0BNDr7yrtxDaiET6w1MjlyaasGtYcgRhyIF8J+pysoFDDwnzSFA4PrwUyUqSDEEthI+qOVdiQDhHM+t5oC4GuKnZkDNNYaTygw88i3bJvyzFcoJ67ITZ9jSHCr0caseY9TULsp3D6nn41Vcv15RKowVDiluRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447616; c=relaxed/simple;
	bh=3vxOEq9ddAMxuw7KJc03nllWklo6LUOa8BRntsGAMAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewldbNuI/FpnObCtY0bKmdyQTM4ofc3eEbyJE0pTu6IxOSslaSJEHwVDOrOn+Z8PYUn0cKG+oRAIGmSK12PvH+FsZEzdxhuWNR4C+fmv4wP+6hQEjd/Lsx0rugxlu35NOuW7nVTWWms/XvUusro8VH7tw3WjfyTEbNN0TGvZZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUk25tfE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so6105078a91.1;
        Sat, 08 Mar 2025 07:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741447614; x=1742052414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzgWOzQsD06Jdg1koYMcussDLSHtrzGSYYq8r0KkiT4=;
        b=RUk25tfEmYkgYdVLI75YIia8uwhh3eHk4P0i8IjiVXKNtm4jToxN38y4irym6Wca6o
         YcdrCvd6Vuwu6e9pskyFv4W7ZQVV0qKtO5xxLwhQy2PxsHYLXUV8IQ5vdFuTutBoCLNQ
         /U39OVO/ROIsoqicPG/o5NXZm0P9BuIab6aaE4Xr8/8omr07VEge7veUNnOpAq1Wcymd
         Qky4aZDJvOEoIHV8xuUdr+Ix0H09UCUTZNXYOSFxnw4h8z6PtwiLHh07fcbNQ5uVyaoT
         BrDJWXmULcMOx58XgkMeCUvTm6CLbqi8+BvkT/nsrQSTyVDtFEdPs1NsQdC31FwRU71S
         6oKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741447614; x=1742052414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzgWOzQsD06Jdg1koYMcussDLSHtrzGSYYq8r0KkiT4=;
        b=msZq9UM5SdT1zMjrMU4aDnaqj4Iu4rAxTkrFjz9/JzbxiR/smYxLGBO5IQ5jYd07n3
         E4DJ22m8GqQ1ZNXpSNy8QhfeIeG4vOM2rm8WSoRxDPzLeftGbAX1hab2hf3WtfQ7YGyX
         XAP9fLJhKfzZqkJLo/ukEjSg8orlB5ceqmk6HZDPWCnzGko2Cr/b8+SQdhfmu6j2EtSX
         3ZjxZUrbDjllFUeqgAIaX+/g4fnLRNGEVe0ypxPx7q9CqL4u8eSuzf/+duZGY71xz1sN
         H1mECt7EsVbt3D4W+iEmbdeLp4zbZM1MIBb3Wk54qUpdmYxyPL+Y3ErIEdHRYOSmnErc
         bbsg==
X-Forwarded-Encrypted: i=1; AJvYcCX+O36H36glNtXrxJPyzyXf3Utm2Jz5UQ1aJ5AjiN/WUeXGZRAyVWgMMDDbOsH/sSFTXnZDyx+aI2k=@vger.kernel.org, AJvYcCXq31q8MRFdS1Mz5BznyWa2UV/GIVMsUimaaVnnQa6ZLpNip/S13PYAtYz/oR7j7rQE/DimCMkV90WIR2T9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jSHShpBZRzLhjRr6FXmtd2FUCB0cGWPtXSc0ldzA81yyPeck
	R4EitlD6kKGtRBCXfeHW9KB9Fu888wW1uxG/obF2P9z26eeEeW/C
X-Gm-Gg: ASbGnctIS0zUk8boZimmTWpMGxdZ7Jz7uft6rZdzKhoWbCTcwsI4YQQW6Qu/C2ZrV2g
	acBYg8+XtFZ+2CVxQaCQ5cXDC/v7GAJOPsu+gqELWbqWXeszAnGzQ4uAvFxZA9Ggr50DnLrCrgx
	h3Hr22xf5BgsyvIrhreU9sEQ4BQ1oF9MW9iQhx0ep27Dbq2gKYax4rSAXdssHgJxayQ8Gzk2IM3
	R1zOilvw0SA1vn2VIukn1DNP1DPI348HOcb11In6ZJtVuKVIs5/GadNvZA1aud3znzSJ6XiViLn
	E61VTRXzda3mo4zFaSpR6mzUWry8Epvj3Vq5JAWxlp/HxqK/5k1s2E+SOCzhFnplQQ==
X-Google-Smtp-Source: AGHT+IF4eqo715T2c4Kw+zbMqRLjZA6vez85MP3KA2/4Us1vpR42Ra4NLux0gr2fDOuXuIHooxQaBw==
X-Received: by 2002:a17:90b:38cd:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-2ff7cea999amr13607119a91.17.1741447614081;
        Sat, 08 Mar 2025 07:26:54 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ddd8dsm47974305ad.7.2025.03.08.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 07:26:53 -0800 (PST)
Date: Sat, 8 Mar 2025 12:27:46 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Saalim Quadri <danascape@gmail.com>
Cc: dragos.bogdan@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt@analog.com,
	jic23@kernel.org
Subject: Re: GSoC Proposal 2025
Message-ID: <Z8xh8jsz-NYYdmYT@debian-BULLSEYE-live-builder-AMD64>
References: <Z8U4mr1vO-TWz91c@debian-BULLSEYE-live-builder-AMD64>
 <20250306003130.1555755-1-danascape@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306003130.1555755-1-danascape@gmail.com>

Hello Saalim,

On 03/06, Saalim Quadri wrote:
> Thank you very much for the initial pointers,
> I will try my best to contribute initial patches into IIO.
> 
> Regarding proposal, I wanted to ask, how to get a draft reviewed.
> Shall I send it here in the same thread, or do I need to send it
> somewhere else.

GSoC candidates often ask for proposal reviews on the mailing list.
However, as part of the mentoring team, I will not review draft IIO driver
project proposals to avoid favoring applications of any specific candidate.

