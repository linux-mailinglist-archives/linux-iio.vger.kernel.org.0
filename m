Return-Path: <linux-iio+bounces-13315-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968E9EB855
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C188285817
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964886345;
	Tue, 10 Dec 2024 17:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyVG0jw6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5926023ED6D;
	Tue, 10 Dec 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851956; cv=none; b=lHKbz55kRhOPPqjTEgR7KBAo+SaisagXqvBcRqJwBJueOHAj13eYQF0r3fC52lfsCTz2zZv24zuv3iOrmRzI+3FXpXYbfYILTtAkj0FnsUzhH7w4/K2o4ZL5m76wGiBdqYLi2JC19k9dxnB3fpTIupLI6+FnqNvHdFE91wJs7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851956; c=relaxed/simple;
	bh=gTC2WbHsHIxo2KUcFsBzSif50gSYtUeB9LXwHQ9ABW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLm+prdQa8L4L/Lk/PkjELpyzQU3H363Np57WcFpiy5xvXRFD3esYue7z22TpFlbhdxmT6G2v5y3P65drpbDRvOEZAt8Kz+ZakL7uSpWRfJzTy6hLjGqGFZ4vUef7DH1G0tKHn0bfFfJaWDDVuaa8cWL3QQBKjLlM9s2Z5OmIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyVG0jw6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3990f53d30so703274276.1;
        Tue, 10 Dec 2024 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733851953; x=1734456753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riVnafjJmAbE5C8uQj3rW4S2epeHRFSM2DiMxirvVAc=;
        b=lyVG0jw6rBxOIjmM7RWSTTUcdL9S18N5ii4jY9A2ovlDB2/wyMKhqoOEkucA8W1jlA
         auZ+0SPVCSHjbOwUbmoU0kQ02OUI8k29eDtnp9lDVQo4R4qI8AWROSOmCwlWvH7oFs+H
         K0BWNBzjuYOI7qgzRFxf6VEGDJ/9ATb3w4Huhqsvlq/+WmvGycPqgXZEGBDrLZRGJYKB
         XA+6ap+Kc9IK5pxFkptAv7nIZ7/meq31VSR173WMIt54MHpGtU/FdvZ9h5kwugCNFuFU
         j12+h1URd/5DpG4CWYNGEaHESf9hZtNrMN1Zg5aIirYTlyoi22gmbLRyJGQPqgMKGP1q
         au2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733851953; x=1734456753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riVnafjJmAbE5C8uQj3rW4S2epeHRFSM2DiMxirvVAc=;
        b=TjJ1wE/510dCOP0zLEzqpK69aZMh6UuCP5OJFlNtqts8giTY8veJKX1APkj9WuJNIx
         8CDTVdONjM3rVhUl2BVPgWvzOEI8Dc2qz+V1uzrOIDlqtGpn8584nQifCLp/ucNfioHU
         ThlrV43XPFUv7cf8yMua3J5dUxXowOmhxVJ0Jb8MquMYdzjqhWhxnCaxDZedEs8EQ3ua
         NEKzeg+NWspe7SkkwaRmnGdfF0gzqTijM+oUYF+fcLu4MdKClhnTEqbbRsYpVznSZr3p
         bXwx2Pj6ahS2ECLszgJ5iFLX0qI7UkzrpvQpPDt7h5k8LPUZykKheZat5V3s/wveAm0q
         ljgg==
X-Forwarded-Encrypted: i=1; AJvYcCV07bAMZJXxMYS/3oo2Lv8o/dbx7PHEy+Tdvy4OrAohv4L/r0p6I0UIu17NBUkYIgBFuawrdLUgHgXvbHwB@vger.kernel.org, AJvYcCWAyHfdFjaY6XT/cuXrZ4Vor1VmhclqeHySnN/xCrak/m0u60ddw9pA5hY5lK3WPxAhdGAvYWR0oAtm@vger.kernel.org, AJvYcCXGv5c2mCgKDjnuh4vn0Kvq0ABTbippHp0PZBWyoZHD154wBp5ntMVkwNtaTvhvzuuiushYxjhdmOxI@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeiAp/2XatG0DGWiLIjj8+IgU2i6lSQ4SPmXqMHUYzZxZeCb5
	6NWqNI1AWjeaX6N7eojgE/1U+np2quT8QxA6tPhfOZ1+eaAGwbh6NWad3vSVcPIj5ZDsn3qBOQY
	jliqqLbMhJk7DNBPfMfUGlPKeXpw=
X-Gm-Gg: ASbGncsSf+e/RTWn1xQS4nLUBxR6ZSOnYSjjbbUkTEvNu1SlYGa+x9l1K1rNxvhNYjX
	3T+fXpdSI1jdN5kelOnrRp/0OqKoJp0qHXGI=
X-Google-Smtp-Source: AGHT+IElEqNpYwYR/RLezdGqAkAtOtqt+SgPG0NdRzzrAOgBGD3TTo394TeFkpEr6ceht5/A2akYwBM00eY+33kThTs=
X-Received: by 2002:a05:690c:3302:b0:6ef:97d0:a989 with SMTP id
 00721157ae682-6f024e6c89amr17580847b3.4.1733851953190; Tue, 10 Dec 2024
 09:32:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205171343.308963-1-l.rubusch@gmail.com> <20241205171343.308963-3-l.rubusch@gmail.com>
 <20241208132750.24ff93b8@jic23-huawei>
In-Reply-To: <20241208132750.24ff93b8@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 10 Dec 2024 18:31:57 +0100
Message-ID: <CAFXKEHZu7SFx9DS3-cy-=JXSRL6CD0L-WG_BACNa=0w9f_yOEQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] iio: accel: adxl345: rename variable data to st
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 8, 2024 at 2:28=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Thu,  5 Dec 2024 17:13:35 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Rename the locally used variable data to st. The st refers to "state",
> > representing the internal state of the driver object. Further it
> > prepares the usage of an internal data pointer needed for the
> > implementation of the sensor features.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> Applied to the togreg branch of iio.git. Initially pushed out as testing
> to let the bots take a look.

Should I actually drop the "applied" patches in a v6? Or, may I keep them?

I see that Dan Carpenters smatch now comes up with some issues. So, do
the fixes go into v6 here, or better separate?

Best,
L

