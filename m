Return-Path: <linux-iio+bounces-20750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275AADE125
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 04:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB1B176B5A
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 02:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3ED19F42C;
	Wed, 18 Jun 2025 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iacWneBg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1E78F36;
	Wed, 18 Jun 2025 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750214198; cv=none; b=Qhdt72PJi3ot0jygql1UfDDbDthUmtzO1F1bPGRmtHjqQ8d0StT8zq6wCxREojdmRT2afRsARekbGq+4AEKoRCGIGzavLBDjeis+E3nxK8RW95r3NyqEz8U7gtavdWCV4GUSgUa/u5BkzCjhc+BdgJF66IqdX8DPl2DaL2Hro+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750214198; c=relaxed/simple;
	bh=npu/fabxBxzJiWBHD/Ed+Cf2wdSb2RdM4A4PgIZsFqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmcXi+OETZupV/L6y/LJOaA7DUZUjgFgxefXdFhekv3k8wEb+xmodX1tQCB4vl30fQZYfTBakUDPlSwFizEBgOcU7Yzjd6Ji4UVZzjW2U7HBbPj+j+0Hw7SmsJmJVE4nNdbcWFYUoe7Tt2TiZLGlAAIjwlJNz+9L9HUVrQ45U/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iacWneBg; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5308b451df0so1780000e0c.2;
        Tue, 17 Jun 2025 19:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750214196; x=1750818996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npu/fabxBxzJiWBHD/Ed+Cf2wdSb2RdM4A4PgIZsFqw=;
        b=iacWneBguICJ5JXCo4D0LGp+eDO7ElMmgITzo+pQW8ik/mM+VOBQKDJGi4qshIT7Gx
         qicbjhsIUOoyELxaTjt0wzSDgR700P2IxDe346UcjrJRQIlDSkJII5fWYEkO61pHWopo
         N5VSRth/O4ag+kNnfUIdY9BmJTGH5SKtkOyqulQVry8+mFx4ZqjkOBnPmsFwvJGy6fY6
         lPQpk0RHbJ9SdX51IQeDPcpY+3AHdjPo4frgrOHeOb/b2AbRgY3DYC3gmbTOz4GEe6hF
         IzJyhlNHOS93RuTcieNIls/VPdTvBZt2koOODnT+Lk3ZnEJJCB1/7gBYY/i9HS/QzObv
         KcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750214196; x=1750818996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npu/fabxBxzJiWBHD/Ed+Cf2wdSb2RdM4A4PgIZsFqw=;
        b=EIXqP7oo6dKpHBB93qEm3U79A1ozxKePNR/K2FJC1EF2Mymc1kiqxYlQ0p1cgnlPVs
         OYgjBnt0v9LuPdmr13vu5rzjHEiVJ7vDDUf+jrg4nJbe9IOCh9T8M6N36mWlUwGoxDqI
         4LjxImrssNU8j+LREWOHbnEp5nXCzlQQrpkEa2DoFTaREPRPqTffc8iiGdkY/upxoev+
         JJMl+MaKTYa741qsozwNXKv0WBuAyCKQaLdAToKtL6WQ7sTlefPZeKNp5fFPIvE5Aafx
         GkbTAxM+jPq79SwkV1h8Ms7SQTdTQPYilm3fJl8zMIXfrR8Ti8sZGDHatgWVZOr2c2pJ
         15Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVmA5ZxYI3BKn/W2FuTIrqhw63LSI7XEGpE9TdlkeoZ07VbRd2mmYCsprcuw0ECCS9MWP1MnYjsFALEizog@vger.kernel.org, AJvYcCW8PyJ8NmatWaWVp/6ItG9SIo5qWjFbLVFlOwanvqVPUuDkJxEJAXSY9mW280EJaFYfvS1NJWgvQwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6a4V/35vPjCKDdZXtA/GyRRiF8x5QnxI5mBTylxtPUVOVW6lv
	sIyTFWpxavtY1Mso3dhkvRiilxUpYdYFIm8pXzk481N9k6Bh5QwWMhOVMXoW2dcQJ0/tWVFItnh
	bwkfZxnQ0JXvt2QnRyz2OrSPPlT0jEDY=
X-Gm-Gg: ASbGncsGvp+J0/9E4xmHVwzj4HYyMF40/ljzFVXEpMApeYl9n0FILpsS7wtyWgXQftk
	HPQkyToII6l8oahkbAHuGaIebQbed+coIDJVmyBwXKNCHzqWr6q2OJNVmZ/LLdEoGcgvFDC4B6b
	QBc2UOWSdAR4jt6aA/mIYrCTCzAmTBFmt2e/FYs1P4HSL4Pvv0J9OC5gu9ZbAJr3rf3w==
X-Google-Smtp-Source: AGHT+IGMhHksFaRRKZn2VFJKvUR68+o2Ry+zTlj8NdOU4DwnlZJ71DRAwYiqAcL5+3N5Pous79DA6y7fgV4HnFFO2oE=
X-Received: by 2002:a05:6122:547:b0:529:2644:8c with SMTP id
 71dfb90a1353d-531497d3ee3mr10569887e0c.8.1750214195693; Tue, 17 Jun 2025
 19:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-3-andrew.lopes@alumni.usp.br> <84643f3fc87425e8c5019eede275791a20872b6b.camel@gmail.com>
 <CANZih_QY5ki3nCGDitE-6FAmDi_dgc04WE_QqvOFwJeu912SVQ@mail.gmail.com>
In-Reply-To: <CANZih_QY5ki3nCGDitE-6FAmDi_dgc04WE_QqvOFwJeu912SVQ@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Tue, 17 Jun 2025 23:36:24 -0300
X-Gm-Features: Ac12FXw0P2s8Am2opBQUoL6Fk0eoBXG0dDVBrC2yoBrw_qflbwog0PEKpUZA83I
Message-ID: <CANZih_SsnjGq+DYsbPE54OV=E6W4bkUH3a+29LnW+hYMF+Bobg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: accel: sca3000: replace usages of internal
 read data helpers by spi helpers
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 4:33=E2=80=AFPM Andrew Ijano <andrew.ijano@gmail.co=
m> wrote:
>
> On Thu, Jun 12, 2025 at 4:29=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
...
> >
> > Unless I'm missing something, the above seems unrelated to the rest of =
the patch.
> >
> Oh, I can see why that might feel unrelated. Actually, this was
> related to the first version of the patch which was focused on
> removing the duplicated behavior of sca3000_read_data() and
> sca3000_read_data_short(), unifying it in only one function. Also,
> with Andy's suggestions we cleaned up the function as you're seeing
> here. However, we later replaced all usages of
> sca3000_read_data_short() by spi helpers, leaving just one place
> calling sca3000_read_data(), so this change isn't as necessary as
> before.
>
> Do you think it's still a valid cleanup for this patch or would you
> prefer moving it to a separated one?

Looking back to this, I think we really could benefit from having two
separate patches to handle these different changes.
I'll try to make a new version that addresses all the comments for the
current patchset.

Thanks,
Andrew

