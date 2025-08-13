Return-Path: <linux-iio+bounces-22688-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D5B251F8
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 19:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646BF1C22CB4
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EE81E2312;
	Wed, 13 Aug 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh3KJ4mX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAF28641D;
	Wed, 13 Aug 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105408; cv=none; b=j4cytlo5Cz2gD8EBouMTT89b8pMKNyTNKXefoDw2/ejanyGGfNJtOXb8g6rzRt3CP65RdRJIvHJTM+KVleuPGSKvbg1qUI1MLluR8Xj6w2k2kR5ZzCRC1oV/l2LQyvk26AjDgnbZQcYsmiF+nU9ijVUwpNcRrcf7+PlfbTxyqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105408; c=relaxed/simple;
	bh=Xv4lAhvsjWNntHfL4yOmUuWkw5uGL4uuqNIXApvCdug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dz+wz8gmWaJOKT+bw3euL2FzMkKaMa3xO5bcHBXvbdVeH0S5UdnC+zw5kBgG+usaKN2vlaWD28zEXIBQPuY9L/WqjSkADvI/MaM/Xp23cJ/5wmEZ3jARJr5j7Ur/yt7yy8TU5cJhLmddP2cJU5TJ+9jPAlmcS7zp5zPTxtqmDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh3KJ4mX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb731caaaso13784666b.0;
        Wed, 13 Aug 2025 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755105404; x=1755710204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv4lAhvsjWNntHfL4yOmUuWkw5uGL4uuqNIXApvCdug=;
        b=Jh3KJ4mXB+5e/JBYkVMxDaPq2U8FiWyAaQXIFAyzV5MmYnlloflRA2uUq6r5fUUFzN
         wjVvTJMB6xeU98fdRb3FPBKQFp4PSH4rwnpBLJi36iOly6JRxjZnlsmbpqx7jPmVvi+O
         rPAqn0g1rf5T5tNRbCv8qk9vCgtb8D8c4pmWlCT1LDURUhk96xha11RxMY/9iTTOEpWb
         eb3NdpcAAqB5yEyJj5qWxNRF1H/jxUhiLR/x+hrLHEEmHGk/N270pYIRLYqfScbvXpz0
         UkTZmqIhHni5mZQMd/ptDeQHo6uRx/XYNAc/Ah14cD/s4SH9J5XtCY7AaNSpSpHXP5mP
         nt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755105404; x=1755710204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv4lAhvsjWNntHfL4yOmUuWkw5uGL4uuqNIXApvCdug=;
        b=Zg0qdO3UIZhL8Pqzd55s8yAp4hcPP5MW1nz3MuAk9P9QEIMy5FcX4Wr7gRQbSPgO9i
         OEzwOlq+rcKLz3lW11MlvUXkMzu3UnrUFAufUafKC/JSc8UeZGSDWgZy77Mg4f4yG1B9
         ncrb2DJRhH419nNEQ+bUHZ8nOq1tvt2JqhA+57OhOo/o8npA3CaCH0k39Q1pXFGfNXhs
         tNEpW2Afyd0lXVnmOm8q3LXGxtjQlFn5YWw5kjipTnU0CY14zXKSoDVN7AQz8dSPkzaF
         NbBA0u3zmdBVmJz2Qcy0KpsPvuDotJbQV/J6SyS9F59+vnCXu6zgrUm6cwwp3SAYaNYn
         TKDg==
X-Forwarded-Encrypted: i=1; AJvYcCUCF4Wx1NSN2nqWQ909ofEYMbXWNZqY4JtXCQOv/pkajm2/4EUOFUVBwVr3JBaudz5bn7JjjCiFvu2k@vger.kernel.org, AJvYcCUGxlOCZEM5vukZgZbzCM6aXmxDjp4DzTSPx0szebL0pk0uirLbmOAarwYjrpGwrBQLP7Z3LppJQ3lX@vger.kernel.org, AJvYcCVpnaT3CYmRUXIv20hsQMOkTf8+G4B5orUXiSNM5mzNz91qdYV+dUtoS1W9fwVZRTh3IOwmmeXEDdzfoXFX@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqpgrpto0WveLkfzGKiCiLjwSkJWwiAXgTHLce0l8OIAiGvef
	QqwEvcnY9SaYzkVSNMCkCh4Ij1P55TCwwugZis+a+Yn3ypHKCLZw2F5ixU/wlSjv/ppGGzDMi+x
	FnN0PjpprBX9ZmPWd7sVDBcf6+s1cYD2s2Vp/Sp4=
X-Gm-Gg: ASbGncsWZVfh1gwenSR6ieq9ZtP3p7fl/m0ZZdkZVOHxjCcN+tc/fBVY7UuPnRQFWiY
	T4NvWj/g9B3cex/Shf+vAI1V/0P2iOlFtKdum6iggYnvo2o/Nv2Xg70dWlyHv9cjJPPYVGSyMH9
	hBCc3APmCCrlSZHk/v2fk3WCB2Icl8AopcTSYLyTZduqOuL/edTbc2/mhN5riVZrero1gVX2OlP
	H0UQUoLkw==
X-Google-Smtp-Source: AGHT+IE2HFkNraf8NLnIgm+Xgi9eZrbgou0iOQhNRh1GSug05eSszGDqkCYkEk+arnxCWdfXYER/BxIpZinKRkfmhpM=
X-Received: by 2002:a17:907:989:b0:ae3:7c8c:351d with SMTP id
 a640c23a62f3a-afca4e92836mr349253166b.56.1755105403462; Wed, 13 Aug 2025
 10:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com> <20250813-ltc2495-v2-4-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-4-bbaf20f6ba07@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 19:16:06 +0200
X-Gm-Features: Ac12FXwB2pfLJ3_CfCqa3_o4aGFcjsVTGB0AxYFsExVGDXl30AzmaBcEAb5oWQE
Message-ID: <CAHp75Vdi8yjFoiDgtq_wSH4LWWzVdT2+Wm-S-W9Dh2jbrs+KLQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ltc2497: reorder ltc2497core_driverdata
 members to remove hole
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:54=E2=80=AFPM Yusuf Alper Bilgin
<y.alperbilgin@gmail.com> wrote:
>
> Reorder struct members from largest to smallest to eliminate a 7-byte
> hole identified by the pahole tool, making the layout memory-optimal.

`pahole`

...

Cool, have you also checked the generated code with bloat-o-meter,
i.e. does the new object file is bigger/smaller/the same size as the
old one?

And make this patch with the one member shuffling from the previous one.


--=20
With Best Regards,
Andy Shevchenko

