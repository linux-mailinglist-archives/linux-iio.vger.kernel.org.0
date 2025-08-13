Return-Path: <linux-iio+bounces-22678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D3B25006
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5513BE52B
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9856286D52;
	Wed, 13 Aug 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/f2c/67"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F50A277C8B;
	Wed, 13 Aug 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102913; cv=none; b=G7B2NTcka8RN36htWtEGq8/08Z7l4/C9fcxLekiFCXokiua2SVGm+RtnpilVmL/nvvPISDO7D0IVNQLZK1U4BT5kCoGpr/gCFMJv/Vy/9P/L8Fn1qnpfXp3tJ1kG1+YNG3UaNHKUGyyLlYM0GyLUVqn6zlup7vZsVNewie7Blxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102913; c=relaxed/simple;
	bh=SbjAzfC7xqc19ZyKjr+F0OqaWcbfKbVoBmLSIqb7gUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q712/kxs9LM1zQafaR1MZsncYfY2NDt89ewbw02eNdmNkXxjMYQ3ro56uVqxoqW9mnj2t9gE958PQ+wcYFy7aI4pDWr0OpJ5H1+D7nZHnn1zp5baAfj6SYjelAOu0sFrsTHN1sPIjWIA3sFrixQGiDPnHT6lNbjU1+kc2uZ6fGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/f2c/67; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb78ead12so4355666b.1;
        Wed, 13 Aug 2025 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755102910; x=1755707710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V53p2xgGxvMjhr/LjpOSzUL0hXLz8c+ehuQIsAQ3YGk=;
        b=c/f2c/67BwqOB6KVpcqmWf42UBGOo33cjrAajrO5cxundp4zUC9nmU881QogaGQuxk
         KNUsyxrJ10IXQvhEoUHUBTVWzPfTDmaumDm5FfsuIarnFp9Zv3BBPqeb6R9VNxtRwfMI
         nUmt3MqjSrewxdzeNuaduEbRmQSzELqf6QCr/HQse1Bn6ty9rpbh1w7Zwk8+iopPil3Q
         fPSi3AaG5b1azpgsFLNdSxBfz/Rv3jadLX/EpBZnIU8byGqLy1imuJ9AqQPa//31RZSL
         A30VgHW7eTScDdMKinlNXgXuGutUiH1MkIV5pakcDKUE2MtRN1pei2HjJ1uV3g3dTWME
         WCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755102910; x=1755707710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V53p2xgGxvMjhr/LjpOSzUL0hXLz8c+ehuQIsAQ3YGk=;
        b=a1aACWVY2zUj0LlMC/icDFYQl+GLq1FS9dWXtqKS+DoXeO+PjB6IiFtfg6pdvM/aCG
         eUke4i/ViEXl2br4U84jgxz7pPqJU1W9AC3SO8Pc/89D83LlP70m6ooufBefnyo9asQv
         8UPJ+HLQrkzSdWJdca2Ft8vnksEHF+GIPdAd9bwUphbkQc5050l9B97GGk2m2K0soyYT
         JocFtrUS56zQ0qW6eYDTOnaNwbhy6CT+xdEwvFfzQ3htk+d2DIFAuGnCNphWB8f+w8oR
         Ne2oB761knhxAGSOIBQJlNQmq210nFSNDtbsKHPaVEdmNF7PCUOMJYLvLZ9Jqw3WB289
         GS1w==
X-Forwarded-Encrypted: i=1; AJvYcCWGWAQqBicWgHWrgn4JTTihtBUfrKtMT6nrmArZZeteGCnUcha916k2nJSmpAXmcJWIX37gFAlTSjI=@vger.kernel.org, AJvYcCX9XrWY8qS3/Xn6BR0QYDFy8U6g/Hl+oaCkqpZHwM3KKiln22xTdJdDdwUFzmKGub71EhzZ8gQdKpVqDkIv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sV3Y0uwe9wqIzPfz3Sc3IqCkXzRFFxS7PAzzLbRQKYUOVy/A
	GAPQilFNlPTlAaHyBZR9mlQMyi5SqvJmhJ7XhgGAMDOkmAjLNH8s+xYpEYg+4tm5iXaD63r+HTU
	aXysA5H+bGKr2SyZDEioANTxVUYitq5w=
X-Gm-Gg: ASbGncuxKcq0dgId1tFKsY/nvsMDfoJRQ5YwuZLlpOVewdhFC5CO9vSwE50uFRLFBOE
	hczQW89G5oy5Zl/ROYoiAW+8t0pHWdAzzz1DPxSWXM+fShXPn5H7O0Lll0KvrVc3jtwU7f2hE6+
	y9zBQUJQVhq7GsjCu5AcOpRDXoW0FOB0ZKOhoIN+66yIGZV3gspzxG0Z0VN+MevFnpKJtrcHCmC
	AYuUcu+xw==
X-Google-Smtp-Source: AGHT+IFN+/9UEaYIopmVsqzTFFShmJ1JFg3773xhcVzOmX8/lDm+cUKFC6tSMnaaty4PTwr7yqc2GwECkmREDMGkCxc=
X-Received: by 2002:a17:907:3f0b:b0:af9:116c:61c4 with SMTP id
 a640c23a62f3a-afca4e44cd7mr352302666b.48.1755102910228; Wed, 13 Aug 2025
 09:35:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813151614.12098-1-bcollins@watter.com> <20250813151614.12098-3-bcollins@watter.com>
In-Reply-To: <20250813151614.12098-3-bcollins@watter.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 18:34:33 +0200
X-Gm-Features: Ac12FXxhGZ2znF1wGqytSvPwyXLJE0lFYKwuAn9dJUBYWMnH6jBtFRLDZTHXesQ
Message-ID: <CAHp75VcG0PoZZQ+=DNqzvdJrTcGe=2V5H97vhter4zeOQz1e2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iio: mcp9600: White space cleanup for tab alignment
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 5:17=E2=80=AFPM Ben Collins <bcollins@watter.com> w=
rote:
>
> Purely to align tabs for #defines.

...

> +#define MCP9600_HOT_JUNCTION           0x0
> +#define MCP9600_COLD_JUNCTION          0x2
>  #define MCP9600_STATUS                 0x4

>  #define MCP9600_ALERT_CFG1             0x8

I would also suggest making the register offsets to be fixed-width, e.g.
0x04 for STATUS. And since these are the most lines you are already
touching in this patch, repurpose it.

--=20
With Best Regards,
Andy Shevchenko

