Return-Path: <linux-iio+bounces-9125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106996B2FB
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 09:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD55281510
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861314659C;
	Wed,  4 Sep 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON+6qAeX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17813B295;
	Wed,  4 Sep 2024 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435395; cv=none; b=HQQc6pnZKRX1rUWpJ5Q7gZlzOPaeV4Sg0bNACshC+AbHYRjmaWoWAtqYxg9Fa2L8sVZQVPv4EKWJDRqOwhjNQU5ZgQUtFR/6VF2jbUtcSasNQ3+P55zKeqqRubJwdnV2PRcrgQLlFLLBOlcE4slEE+AR1FwYbkfjxZve7nL2QgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435395; c=relaxed/simple;
	bh=CUEv1UkwlTwYYJfodkqCax4W99XlmzRGrc5LXZ5TUdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpmbvHHRSjpexQDkVxeapTkpbG1tHrsAQnwdd8jnDJ9lcPHaL+DyNcceMQq71Y10J7++TjGdDw0rh/voPkv70HWADjULE+UFsa+EJBvtxqUA7Wi9PCnwKVqqxar8lt0s7idSUo9HhIhDtEJ8Xlfni9K9FL7gqmTT1Q9rbM3aeG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON+6qAeX; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53346132365so7649525e87.1;
        Wed, 04 Sep 2024 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725435392; x=1726040192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUEv1UkwlTwYYJfodkqCax4W99XlmzRGrc5LXZ5TUdI=;
        b=ON+6qAeXAXDiMhLZbkURUGu0N1uXwBQaJF/qE/DR0fygfcXXDn4xO8tzgwfXXvo+JM
         IpPaMxQTee+MeN/lnVCRLq2fyeXvgLB7U8NFPe3RF7AWYyItbSPn0mZgoFlHjcqqw5Ts
         7h2xMWVqwvCOtA40YB7tuN0KgkXYB3hLfe9oKG2zj0IxUJT8D5Ljp3PqK8JlGYV2iu3t
         aSd9GWra4vHmknZtwJMs/FM8lgy6Snu1fxZ6ok5BA11rexD13ubVfibdogmoE5cVe2hV
         cKhMVxAwjXN7WaGK7S+J0DuhgMQlQ0ecd86B0X7s968Dn0Qd0aIbwSraX3kusJUROUFP
         jW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725435392; x=1726040192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUEv1UkwlTwYYJfodkqCax4W99XlmzRGrc5LXZ5TUdI=;
        b=q95aOtOJ/izj31UHLU8/BVPIeWRAWD8attMOYJfCvQ95sx0u9Z8u0z/yg6+NSjbO3+
         H+nHQoZIc1fZtl/qIbjOTaWcJYQjC5n8O1YU+byMR+1yD7ObLZsmbXTqH5W3Zwijv0KN
         mk4fEaDFGEm5PtzE9Rm72ZqtOKgqGERq7IHXk2fr4osgyqvK6ZIGLwPVzm1K1CqBJzMH
         /ZhcfCW1xWovf0+/nmCBNIuwSJjmjoQ52Ot/zElfZPjD6AlYNW/cVyReFyyxVLnZzpfM
         FezdxYWCV6ntYVVzlkqthUh+QrL/SoxvwnZ9R9B9GPSLd6x6ZdJRR/s8mZ00RBQOj5VS
         0vkg==
X-Forwarded-Encrypted: i=1; AJvYcCWNFG9W3ChcoCS6EMaib39JN4DdvFM2nvyuJe3Gnlc7fc+AZJHcMYEvSeSMK2o/w1htwL9S6ddIMDrf0RuU@vger.kernel.org, AJvYcCXlmlJq6jfrc3akPjN4OGPDr7M/27J1ONMgsltFDjDMVHbX+h/FX4VWKaSxC7rQSg0hCjt9plJW2/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrwm+U/fo/D5mvNlprDCUfGpH2wfotk+Qc6zdtxrtjWFod4Sm
	wzuJa87tytyLaORnWgFHjTb7DGMclvHdLuiCnpb52lx1YUPDlP6pWsyF2GtlLqdidSKxGNMimcs
	pdPHbyfYkt26zUDA8MoTwolTL0Hk=
X-Google-Smtp-Source: AGHT+IGtpildsLq6ZKlKmViCvFkk2PD3suiPL6bTQKehN/78sfI84GD7Jukka47fH3OEkNuIMK7k1FjxZCAoVquiEPM=
X-Received: by 2002:a05:6512:ea7:b0:530:c323:46a8 with SMTP id
 2adb3069b0e04-53546b0b7cbmr9835751e87.23.1725435391338; Wed, 04 Sep 2024
 00:36:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904014253.2435-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20240904014253.2435-1-zhangjiao2@cmss.chinamobile.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Sep 2024 10:35:54 +0300
Message-ID: <CAHp75Vfx5q5GaEGRB0zZv2_Gxc8FMoD1tqmmd43ZVJomZTqmhA@mail.gmail.com>
Subject: Re: [PATCH v2] tools/counter: Close fd when exit
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: wbg@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:42=E2=80=AFAM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:

> Since fd is not used in the messaging it's better to
> close it before printing anything.

It was my comment which you addressed. Thanks for that.
But it does not explain what the problem is.

--=20
With Best Regards,
Andy Shevchenko

