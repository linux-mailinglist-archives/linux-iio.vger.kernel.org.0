Return-Path: <linux-iio+bounces-8980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E789685F7
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D71E1F23333
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1B9183CB7;
	Mon,  2 Sep 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoSnJ3/v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C438175A5;
	Mon,  2 Sep 2024 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275758; cv=none; b=RiWay9TM0fE/IROwFBWWXU3ZL2kNl921ENOKKKyGYFcirjhtNSCRhF980I4G5Qy2KV7l+FkienY67tFLlpYTA+S/yFMPkhc8en9iZhzWbkPU+SyLaaFJtMjqTKQqgPnCWYS7Am4nS2eRWRrkqrIFpUH2Y3sSbP1eX6qf5C09/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275758; c=relaxed/simple;
	bh=VM1KkI/ONZ0bStFhvWoNgABBW1hRe7xL3Ayz2rtobDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xbl+/z68S8Cwm9H+0rP6bkOijAi/olUTy7/eZhecUkd1bE51XlhRHu0gZRmKQ9P/yggM1rP7ibcg+9HvDXpFtHExYEXohJhi8AH2rKeuhNjXP/T0zRbeAnkP8bSX71fbNdtJDlPzVebE4F01qbrVmb2JJVxWfaG6vZ5SIayGP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoSnJ3/v; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d86f713557so1898591a91.2;
        Mon, 02 Sep 2024 04:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275757; x=1725880557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM1KkI/ONZ0bStFhvWoNgABBW1hRe7xL3Ayz2rtobDg=;
        b=NoSnJ3/vFpHII71JkFmXjwQ5eErCouHtJigMfkg0/NWe1Ofvp8OAROwMze0pd6R4/O
         /uzI6xkkG3U4hQft7buu8ziqvvuNnkVoXAiLNHJCh6umDf+a8dQjH9SH5i5oplxB0ijd
         ydcPBHPwEYdTe7nweVgZrNIQnclNhyvfg2310Dpioat6F0hyzOXIbHOc/w4g5SQi5R6h
         5ftuO2jiqoA6jgA5j0e1sute54Ov4guRAnq0k89zEUVMOf3oQ5+sJjIS2ATfM1CQICEY
         /16NVPf10F3FJ4/4LYioJGCB7xtJOU4H5vSn/kLICpPRpIsi1uarkZ9n/+1s/BwF0pMT
         NGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275757; x=1725880557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VM1KkI/ONZ0bStFhvWoNgABBW1hRe7xL3Ayz2rtobDg=;
        b=tJeZuLkQtECvhgG4CgOK7USErtERNCqxkS8dpGVS7qzdVmyRotJXBhbYrYmcaMpCop
         NBn5/KPHpIZvyBotsf1D28YGG4N0zDTJumonIaM9z5QkxC5/AyfirLKkdaMvDIvGotXl
         rDpqTBhsCnqhYEt7sA06RubPt+5igWx/U/kXMgGK9EoqIQDlftVQrTklYRwwqr0kVSsH
         A4oYjwrlp7EVfx1Mq6XC6PBWcCnIQKRlLYDHCSHhYYRU9Hv3Gyuhaz4STjmuqr3cvWS9
         Z0M6/TELL9KFlvbYifH+ReOIConVQMTi3jmKGQHe11QQQdMA+bsg5L1qbkI69TfRNdpJ
         Cu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBnLa57yhFCVKSx9XW5wqtIVYaa25lA3BDFo9i5Dx2iXA7Pd3nSulwVeA0BbxY5fq+8a2Kejn+KhjsQs39@vger.kernel.org, AJvYcCW3BllbpsbPtBmhUcPfLjq0QHPUn5h/cs6kZ5Q8v2VG27wEiRPJewxWFv6ocmQR8NFyO/ae3kFH8Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6n1pNqj4sYN4JorKBijR6VBtcyMPoDW9TRu4lh5jvGghHhpJQ
	QJfROakuxQScsNrQyfCApBdjO4Qr+MMUbKOHrBpU+TtHPnZBsJph68LMaHybe5b2a/3y1uDhZrv
	zBgKYnNs6zee7tIz7W5d62eSsY+g=
X-Google-Smtp-Source: AGHT+IE81zW+lOrCPRaUuYXf0A5Av9R4A3dq/QNFsKo7eKjLoIViJmbiD/PhbYNoee9x5+0oEmqgbkbeTDXmmyB4pP8=
X-Received: by 2002:a17:90b:4011:b0:2c2:5f25:5490 with SMTP id
 98e67ed59e1d1-2d8905ed0aamr5965279a91.34.1725275756736; Mon, 02 Sep 2024
 04:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901091214.15199-1-gye976@gmail.com> <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznvriPOTZHFyNVoNkAce5q2vy+itN5yJ20kCQw3Akn_PEQ@mail.gmail.com> <FR3P281MB1757324BA65151253A82F8C8CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR3P281MB1757324BA65151253A82F8C8CE922@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 2 Sep 2024 20:15:45 +0900
Message-ID: <CAKbEznv+2u_QV8+P+dYN_UygKm2PhzgVgTM+uEH9crPRQ4a8vw@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 7:04=E2=80=AFPM Jean-Baptiste Maneyrol
<Jean-Baptiste.Maneyrol@tdk.com> wrote:
>
> Hello,
>
> it would be true if there was a return statement before the 2 labels, and=
 that the 2 lables were only error handling case.
>
> But this is not the case, since end_session label is the end of the norma=
l end of the function, not error handling. This is very old code and not ve=
ry clear, I'm sorry about that.
>
> But the modifications are breaking the code and interrupt handling will n=
ot work correctly anymore, since inv_reset_fifo() will be called now every =
time the function is called.
>
> Best regards,
> JB

I apologize for the confusion, I just realized the logic is incorrect
as well. I didn't test it because I thought it trivial, I will send
patch after verification.

