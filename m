Return-Path: <linux-iio+bounces-530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FDE8006AB
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E547C1C20E2E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Dec 2023 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E61CF82;
	Fri,  1 Dec 2023 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmmgrh6d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D584210A;
	Fri,  1 Dec 2023 01:17:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b57fa7a85so10955045e9.1;
        Fri, 01 Dec 2023 01:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701422246; x=1702027046; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YY8x4EOrjg+5RcRtDzP4+OrB4jINEh0R/4Xw8daSVdw=;
        b=Hmmgrh6d10DzkNpfPXiIBnUfZ8ZhP6rFHjB+gYkzxK4iqjulvRqypXwJXsxZrYPdMI
         KXpKSht14u8cuIanSlU+m78yH42fJmP3yaJjJwuQCuJutNf40QXV3Ohke0qOsk+1/kzF
         0whKXuWol/VMzC0dBM5LmuTXc5BDoXI0pMCquPW+GNXLLYAA/xtDGIfhgYqRopVxQJ1v
         NtohBJdt4v2rpZfkE/D6yQXh5qc5olPolLBCDUpiNbdXD1HR5rDPnP1Yj1ct+GCTY04+
         XLPk2UAKZjnhHwF9C3TkT8VrnPp3D5VVvqVkbiCWxtXPuBL+M8P2nYyY9oVWRcJDe1gz
         FPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701422246; x=1702027046;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YY8x4EOrjg+5RcRtDzP4+OrB4jINEh0R/4Xw8daSVdw=;
        b=YpZsT5vIEP93E/F2AYQkasPoPEgSBGK1xcfPysPxNazg8r6lo7Zxo1DZnCZXGQeuOI
         TC3Ar2GG1Ko3dk/x7pJGm+WaB7MOKvFaSsaubqLC9+fsZEpTZfQO+ud+OS//9B3DOBy4
         QJqcxrDT10rnRjJSo5hyukQmnqMLsLYxrSavlhS8xjnK7E6RTaObR5XE6YEtFUvFVU0q
         Xb5NkHULMjBgOiq3A+xFKnZcyWb7E2flEAJxFKS7/lrvt5YjFziZCyubR4IiwFJvf1Oe
         MH1WA7D2G4XYMikEpIV4inxeiFI2IHz+2lDTt8WdfptI7xHHM3TdOBrFCeW76IxNaqr4
         HrCg==
X-Gm-Message-State: AOJu0Yw5kcvzaMf1jkTr3w/0/NCq7JYbQ2YoPT4sFSj/l/eui0iYxMLh
	rYegaJ7FkTUQ+mwqA05TkpIltHMkhrSG5ijb
X-Google-Smtp-Source: AGHT+IGZLnNmIZ4M3p6jiid/cJ/m6duNJckpZ34y6yN2cssBQr9jEQ5vAveCcNshoi0HNyu2/EaF0g==
X-Received: by 2002:a7b:c041:0:b0:40b:5e56:7b38 with SMTP id u1-20020a7bc041000000b0040b5e567b38mr445560wmc.129.1701422246174;
        Fri, 01 Dec 2023 01:17:26 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id q10-20020adfcd8a000000b0031980294e9fsm3639149wrj.116.2023.12.01.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:17:25 -0800 (PST)
Message-ID: <66957bdfe89826d22641f418f237af4104a44d67.camel@gmail.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>
Date: Fri, 01 Dec 2023 10:17:25 +0100
In-Reply-To: <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	 <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
	 <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote:
> On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
> >=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Convert the driver to use the new IIO backend framework. The device
> > functionality is expected to be the same (meaning no added or removed
> > features).
>=20
> Missing a devicetree bindings patch before this one?
>=20
> >=20
> > Also note this patch effectively breaks ABI and that's needed so we can
> > properly support this device and add needed features making use of the
> > new IIO framework.
>=20
> Can you be more specific about what is actually breaking?

Device name for example changed. And it might be some other subtle breakage=
 but that
was kind of agreed that would an ADI problem. I'm also fairly confident no =
one is
actually using the upstream version of the driver because it lacks some dev=
ices and
important features (like interface tuning).

- Nuno S=C3=A1


