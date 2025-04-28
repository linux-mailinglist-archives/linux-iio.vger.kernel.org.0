Return-Path: <linux-iio+bounces-18786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAE9A9F927
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8C33AC21A
	for <lists+linux-iio@lfdr.de>; Mon, 28 Apr 2025 19:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949D2949ED;
	Mon, 28 Apr 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvzUjNIO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA419ABC6
	for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867067; cv=none; b=SJDl4CvoPG/SY2qkf+EIpw7xnD/K+IoGKTUJGcYJXnEl0xopKIq4WPltIfWr8zC/tEjA2VN3IYwWyIG54Wu1tA+Hoae7AYnNfbvI7GfDKbUxOyZ0Jk1NNwhZLM0kR2Rdug1TBvhAiqeiXD10BMFnUL1LZj+aCsY0cZMi4O0Izi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867067; c=relaxed/simple;
	bh=xm5fmlabw6cq2HguCcW2Jk/dQrCb6iW8chSWE0YMM3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcEF1TBIyw9Mz5W8U6b6FlY3i3vbQWJLl0BRBVYYq61xlqVfByJLm6FnHe3gFN7I23BnaspvbpvOXEoV0oVaY4K8vyvjMP6WkXdD+XymEONNK23pUi4Nj2KHedKmbbhoAITBTWCNWsOv1nUX0NS2gCKC7xySPoSzL5C6dyE9zhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvzUjNIO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54d65cb6e8aso6662017e87.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Apr 2025 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745867064; x=1746471864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm5fmlabw6cq2HguCcW2Jk/dQrCb6iW8chSWE0YMM3k=;
        b=CvzUjNIOJfjW93sMWUpesuWnUD/fn5lNurD1yEVaYzXNTmnJD1XxOLakAD1VHjdVg+
         c3asIow3gPla7t1ex0f1oiQCJQtw7MKEos2+S8OWsL1DXX9BdtDG7lMOt1XLWJSWtUt4
         5MO6oc4/MxNwZV5WSAKhlBX3VxllMY/enys7FtO0CMOcMrdom8n1OyW5DzuW0TpU2R4R
         G5OS1gG7RzaXpNOx7hUermCZ1WnOjT8ysnIAY81t/xa6cXUkC5gCm7pMpXM5ZnfzLvSG
         +cFfjhDeUghZ57alB87LU6wG2KV4pCtgPY4m7FhUUF+pzYv5zgkHCB0ZHCfyvgPpUPkE
         JqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745867064; x=1746471864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm5fmlabw6cq2HguCcW2Jk/dQrCb6iW8chSWE0YMM3k=;
        b=nWgQmM3DsD5GcP31HMLF7KimFudflnfBYpEYiblx6csgR+XUis8u35rQJtv6Ok754N
         tkEs3OH65kv71Q2s5frGduWsXNFTy/HJn60hw8d5GVscWlziM8QcT0gX/ksSu/yL8w+P
         eHZUzOPbAVYX7MqaqnD2Ej3gFTsQO+T0K++0bd6TmN2sGhj+i6lCGUD6Ru+BJqu8cK37
         0uVLKVArfGh6MkWk3fd2qvv053V8Ca9VbSWKF7BEY1rYPgT7PSgTR3SifHoiIqG5EsIJ
         Gd08NuBztEWYkvoSiRPvyqLCN0lcOCmvItCcEFSjDzCHCPPBCndQGJ+Liuksy+erms2D
         SMFw==
X-Forwarded-Encrypted: i=1; AJvYcCXIwDgerbBrBO4Pf3VJdJgRb2VHpKJD8SE3/oXqgzARrzj/8TRJYvGhpdl3TYa2YsDkrPqpAgb+hFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiTFRzfQ1nFX0oh9LVoLfH1TQUgySI9wuLxAXv888U1l8hir8u
	GP46fOeqXJ8lbNmdTxEFUmxx2PQC6wlDiW6Oi1KP04Wp9TSN8Or3/JYmzXFYYn3TsmjsWMb70k5
	L15Lf1qVI4fFaCuG/UkcJ3ub1K4c=
X-Gm-Gg: ASbGncujgUCtUkQhZROLdC6OYlCx+WE6JdmLIv5JTNV6j8KIJTi+2IEQGXO7AScCOhf
	H0KvFdLVgZUOv0TFtyc7KR8O0Z45Ze4u1o307ZJZIBKly8zhnreHXkERNraR1FVjz11flPL3les
	b5qXkYZnZCpB2jPma3i4veBrHNxW5xmBir7zI/7KKSztTCu9Tqocrdc3TLrbtax57d
X-Google-Smtp-Source: AGHT+IEdOT4rpgdbfW1ukj+hdHIhFRfyTjnK7vwCjsmx7H26M/J7hX+hrRiZNMG8tMY/7BNpg/HYP4qqpuxbid871as=
X-Received: by 2002:a05:6512:33cd:b0:549:8ebe:b3c8 with SMTP id
 2adb3069b0e04-54e9e537c13mr2780e87.11.1745867063439; Mon, 28 Apr 2025
 12:04:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei> <de99d175-a571-43a0-b254-606ba03948aa@gmail.com>
In-Reply-To: <de99d175-a571-43a0-b254-606ba03948aa@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 28 Apr 2025 16:04:12 -0300
X-Gm-Features: ATxdqUEUMgBv2AN_-nwQzvqGbdIOOI79XUJmIp6ZE5dA9G6fxWT630ZcKzb8uW8
Message-ID: <CAOMZO5CtU8_4gp4gM_DYj-6PCTROT5N1jRqb9-6PMq9PxOy1bw@mail.gmail.com>
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Mon, Apr 28, 2025 at 2:38=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> I believe it'd be more informative if we printed the actual bit masks -
> but I am not sure if we know the size of the mask. If we keep printing
> the indexes, then we might want to add brackets [] to indicate the value
> is an index? How about:
>
> "available_scan_masks: mask[8] subset of mask[0]. Never used"
>
> instead of:
> available_scan_mask 8 subset of 0. Never used
>
> Would that be more obvious?

I still find the "Never used" part a bit cryptic. What exactly is never use=
d?

