Return-Path: <linux-iio+bounces-25440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC256C0917D
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5F21A67369
	for <lists+linux-iio@lfdr.de>; Sat, 25 Oct 2025 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E032FDC25;
	Sat, 25 Oct 2025 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtNJdJRG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255226290
	for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761401575; cv=none; b=gcSDNnnSu+t3JDyKqI7pyEQGropsJyfbkUzU1G/K3rEY9BkrLXlrTWQ+vhOoLoDbxf5k30dIu9iP4zxUiXn82pGeIJmIDvy+6ZQggHE2zinQAW7TYAzEgBZFtcSClzBEfv12qrFvu3vPmVY1yLGn/UKoQ25Rb07Ylz4WqIbvQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761401575; c=relaxed/simple;
	bh=1uBMmtCh/viplQefOR9TqmDhRgZDm4IZ2AI4MnuTSUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FltAcPRUxqyBoBjuQTGPvXCr51wNiwGyWDa4b6EL13Tcg480zI7yDlBETZh/ywmpaLN3TsfK2b7bE3ndlH+lxCwxXj5yGC577MMj29/kS98YavYaqlLJVq6ft7moMxDIPhJv35acxILuZBFbmQxJhMlIvhFO/rpVxEmeqP+7pdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtNJdJRG; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cfffbb1e3so1996739a12.3
        for <linux-iio@vger.kernel.org>; Sat, 25 Oct 2025 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761401573; x=1762006373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uBMmtCh/viplQefOR9TqmDhRgZDm4IZ2AI4MnuTSUY=;
        b=WtNJdJRGhJhKY9eTX9WQhJaLclB+OAy8kga1rMjP9XQs+9yVhu+2klNSjuqIciREFI
         yEugC81YPggsqau70moopF/ab0RGZfYfj74QWEm/68mpvRT+cEyCuekeAjV3EOS1mjkr
         3HpACcDZV14AWDOouOkPW5DYIz1yN9CwyAPZPHW/JwvXi6JOaB6zDNGWhQ0XEGpJ+K+h
         CgX2MiBur0DIBDFQLF5ufs8HDOHCWX/MMQ90MYlGGX16N19SPPEQB6dpboFhWEVgeEl9
         zFd6hAIoQIuOq/SK+PhDge75FvlKgRsZnQ25RoGtxWMCMZdBPaYODVpqU3LrnifVM38n
         GkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761401573; x=1762006373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uBMmtCh/viplQefOR9TqmDhRgZDm4IZ2AI4MnuTSUY=;
        b=WBGfOCuAbk1hM4Iv48EbWXAcLaxgo2l2oMOc4FPGOoA9E1W9jIZ4VBcgMJbln3dH4b
         AcrWOa9MiucHzULFIDIXTWsON17+XPwVMsAZW2N1H6K/7iIr52b0i90vgu4zKye/07oH
         4IjbUmtcsmRTGqqBMURxOqPvEMqBJkkCHEIESo2sqNlqpfnje1JVb/4aC2tfTtdXQyDt
         bJansUn+CCtKDpXZap6kVGUCSvGmQV7Q+/EaANoW5PU2PeUYEDVGKaB4t5J9GS5xSPn7
         HMw/TBxDJjqgiBIGqrGNbnnx2OWHknZsRkRUT3DJypstASyNK1PdHpPtBeZMxuOf9Y/b
         um4g==
X-Forwarded-Encrypted: i=1; AJvYcCXV0cgppKpAocSpTroEBmzXFNOJuPzY06BsBBBVqhbtL3A4WDg7e3fTdJmmQKCHLccs7dFWS6uBfNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx141x6ADYLKdUOEnGUBjoFO3L37n+msBmo64DeDUXjGlfke7JG
	hnWLwLH2UWyOYFrdYHDM6bzPIdrDaZCoakqgQbhqFST/GTks9VrXBeOYxPtjGEdiVd/YPhh2eWs
	4036+sCHikU5H+3ALYC1kfCT1XfC9obY=
X-Gm-Gg: ASbGncupKaXSrtPTJZsb13EGKFvMSW7ihiQEZ8IVbVGAJ5YKXLV26n16DU3Q46zm5C5
	4ft48XGk9qciqs/CTgYh7q+I/5a72eLPxWTt3pRtKxmuo+KnkMKyD6cyV9gxRVpXIdNiuQ7W/qr
	k+MUrfgLm9nPa45drIUIooFTRy4njSfOljk9dCaJ60cDdmrWoM3kVFbvPGNEjtUivCYtNfmF7DU
	fgC8uS8OaP8S0r/V23+o4jeSGFwvIxu5Rlk0QKMcODntOlGAXuC9j74N9A+
X-Google-Smtp-Source: AGHT+IHWBcBT1UJnsX1+ArqbRdHy3UbLUVR8NxUERGbtq9s9Z1BL9aKulgmICq4Bc2myVg4Yr88PTHuecN6P/fiuIp4=
X-Received: by 2002:a17:902:d544:b0:261:6d61:f28d with SMTP id
 d9443c01a7336-290cc9bf243mr398462235ad.50.1761401573179; Sat, 25 Oct 2025
 07:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com> <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
In-Reply-To: <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Sat, 25 Oct 2025 19:42:41 +0530
X-Gm-Features: AWmQ_bnWn9FhlmpJBIgkveJcUc9siDTgKElhxu1c1ixI1RBDlVYzhMcYHK45t7s
Message-ID: <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 7:05=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Is this the only issue with the kernel-doc? Can you run manually
> scripts/kernel-doc against this file (with -Wall) and check, please?
> The change itself is okay, FWIW,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Hi Andy,

Thanks for the review!
Looks like I missed another warning in the latest linux-next:
Warning: drivers/iio/industrialio-backend.c:1069 No description found
for return value of 'iio_backend_get_priv'
I can send another patch to address this if you=E2=80=99d like.

Best regards,
Kriish

