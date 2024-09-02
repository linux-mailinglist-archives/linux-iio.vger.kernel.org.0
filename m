Return-Path: <linux-iio+bounces-8951-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDFA967DA5
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 03:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD77F28130C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BC2225D7;
	Mon,  2 Sep 2024 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amcn4CEP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA68EAD0;
	Mon,  2 Sep 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242393; cv=none; b=qqrF32TZn10x5EWfitzXigKTR6wcmfDfYZEWOpbk9Z14vzwGWpJrEEQNTxwiaF9fLqBD2zQA/qL/UsRiBxjLunoa3D0H4mh6X6Q6cMLTFHow7xtOkXdTvubnjFBwvVpnK7wkt+OAq6nVd1QUgfXW0EXfdtqdwpJE45jZ8Z/W3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242393; c=relaxed/simple;
	bh=iNy45UIF0UVsc+PI4+1bSK0M8zCdHe19XHjRvy5HNdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzJvglrSAsk/+qULfrlyZ88JUcezUefin8tEIGTkBzXFMQ/Gz+otu39qw0kTYhqVg+QVw14+KYWA0Do+i+T6KCoLkiqEUHmHfudvtzxbqVWWwrd1VshD9FyY+X7eC30Z344deZnsAWMw8pnqvgmvKCGviwtKAzlFwWBJfdWoDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amcn4CEP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-715abede256so2696670b3a.3;
        Sun, 01 Sep 2024 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725242391; x=1725847191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNy45UIF0UVsc+PI4+1bSK0M8zCdHe19XHjRvy5HNdY=;
        b=amcn4CEPGWI0WmF7yNl7ECOxUnpilAuVAgTF+kz5aaDdTZY/A1Dk0Pg0bQV40hQLvZ
         hhyGImP/h1Qcljpluuw0Kc0cRFbd8sYUtJNhm4b1wMRHxXVm6GMdnIIrBp7OpWcoaZfh
         QLmhIroAma0YOA52R+mz63L3Et7yZ+qUX/+8kJr0IFa4J0KLINrxM/dZ7v3UBWwX1J4n
         /gLHZ0ShemVWuxJ3itFgFJJ/EsW7DhXDGYaGjPDk3xIQzRWlZqW4ezqeau5IvHvO50sf
         MFhweBWAlSv48+3BAFlN4mwzjVCqfMCblnazwkJ3z1XOtb+OJZV5bzNiilAi1Qoqa5Fi
         iuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725242391; x=1725847191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNy45UIF0UVsc+PI4+1bSK0M8zCdHe19XHjRvy5HNdY=;
        b=BSfAKeXaGiSwscS9aKi/ADk0Y9nmoLlGY6+2XYj3rJ9BFfpOewsxgRARO/mNkIZyc+
         FXERBRMgIzKzBYSsm3ync6xrB6/1DLx9LWhj0pfa8cLJHv0NaStEwIaxF1ixLEhgApM7
         v3wLSkXwAvMvWbF8QDKATtVHJ5bfDNgiHT9KbzL1kn2rJ2r8BoCwwAW3gYGu1idvtttW
         afMl2p16M9g3FWZAATWPigMZqFOA4rz1ahgY2GTHmmH3I6kj6201r44MWltY7bX6wUmD
         1Hb933P/xeAQzegSPOyz52lcekf7O+yi5RmTVLKKUFKMINyzvn2bZZGjypU3B2f4O/3Z
         y1kA==
X-Forwarded-Encrypted: i=1; AJvYcCVx0+lxUxiqwwL8PdrWwbHeGDl7AKfAdrZJIVAefFTojG9re10GV3f/qtTzyEW6dij0/o7WdsxV5UW4WE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjGnQspYm6WA5tOgCzEQmqKFkfBEFoEFPxZGljGk0+ymB3bpV
	UswhiroVUDXd8nl4LHSErd1JAHResL8zTJ7nPdVZAP+z0Uo2Ttn5MBgItLaap2NeMeFQEBy86vF
	4Pc1yuGcR9gJ0hCrbGS1u+60LvjEaAEiKcE+dyJIo
X-Google-Smtp-Source: AGHT+IFnxlVMWgifosrO7uLXFxeOieNFWdrySlhYeKMnzoqczdbbf52CqiWyYuF5Qln8Cy8FMX68Ldls412GjKy0NPw=
X-Received: by 2002:a05:6a21:1192:b0:1cc:d5be:4c7f with SMTP id
 adf61e73a8af0-1ced6087ad5mr3914086637.16.1725242391023; Sun, 01 Sep 2024
 18:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901091214.15199-1-gye976@gmail.com> <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com> <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
In-Reply-To: <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 2 Sep 2024 10:59:39 +0900
Message-ID: <CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:16=E2=80=AFAM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > Hello, I apologize for the insufficient explanation.
>
> How will the commit message be improved further?
>
> Regards,
> Markus

Since the code is short, I think it's fine for now. thanks.

-Gyeyoung

