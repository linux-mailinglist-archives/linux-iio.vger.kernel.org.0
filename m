Return-Path: <linux-iio+bounces-388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3B7F926A
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E364A281107
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 10:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F26AC0;
	Sun, 26 Nov 2023 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=p.jungkamp@gmx.net header.b="k0T3WcDb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7AADE;
	Sun, 26 Nov 2023 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1700996352; x=1701601152; i=p.jungkamp@gmx.net;
	bh=KOgWecDxYY3g2cM8BZQE6G+u1bTa0v3+bYLlKnXNiM0=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=k0T3WcDbBY0WHIpu6Tr6Vd5kigXuS2Wk7RUnM3CO73oCAAlP2gvCZnKvTNhOd5TZ
	 V5Td5vqOfBh1k3cjH28YYzLR+PKz/PvSLpx3+wAbC/af9vCRbXbY6HxHmcmuor+nv
	 OJXuQXE52C2gC8N8aDDnx5NvwuuVCI8QAnyEp/nNWnXfIyYDPfCvYt4/amh6XG3fx
	 M120+7c2j/X+5Jf6NTAcFynFQpb28CA0smUhlfi4C+VtBf49UBRSti8ZNw6nU/qzm
	 9OkTDMynBqHusuWPyFSM5HwIiqxqFZPOK4/x7Pv/uGzci7a3xILSgj6HKI4zov1r2
	 WBnj7G1SWiI0hkZQqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from yoga9.fritz.box ([149.50.180.176]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1rD0YN1KeZ-007WMJ; Sun, 26
 Nov 2023 11:59:12 +0100
Message-ID: <94eafe4dfe176d0ca01ddbd0ec599e3c5fb2e0a3.camel@gmx.net>
Subject: Re: supporting binary (near-far) proximity sensors over gpio
From: Philipp Jungkamp <p.jungkamp@gmx.net>
To: Jeff LaBundy <jeff@labundy.com>, David Lechner <dlechner@baylibre.com>
Cc: Sicelo <absicsz@gmail.com>, linux-iio@vger.kernel.org, 
	maemo-leste@lists.dyne.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, 
	linux-input@vger.kernel.org
Date: Sun, 26 Nov 2023 11:59:05 +0100
In-Reply-To: <ZWLKsVu/v8m9nA0U@nixie71>
References: <ZVevR_ajeB1jfDS9@tp440p.steeds.sam>
	 <CAMknhBE5A3w7ntdWC9cFDYSrPQNPoH7sQ5PVXKEy6MAJmZ93SA@mail.gmail.com>
	 <ZWLKsVu/v8m9nA0U@nixie71>
Autocrypt: addr=p.jungkamp@gmx.net; prefer-encrypt=mutual;
 keydata=mDMEZKA9JBYJKwYBBAHaRw8BAQdAKwP+0RjhVSZAbfCZU5BxzUCipG/upiZwEhd0dJ0U//e0JVBoaWxpcHAgSnVuZ2thbXAgPHAuanVuZ2thbXBAZ214Lm5ldD6IlwQTFgoAPwIbAwUJAeEzgAIXgBYhBIvrh1FNoSXo9EcYWLGJCFcFRbXEBQJkpDk/BQsJCAcCBhUKCQgLAgUWAgMBAAIeBQAKCRCxiQhXBUW1xMMdAP91HOdFUZGolehv9RtGA4nXc0TO+na7g6MiX3Uct/55zgD/RCpd0Nif/TVMnzblQ1w6zQAUNuKgeHEyFqSkzxr84gK4OARkoD0kEgorBgEEAZdVAQUBAQdAEvFkDBEYCk0fpiigqdy0Dpy1AHvRhyGI6PIoELG+MCwDAQgHiH4EGBYKACYWIQSL64dRTaEl6PRHGFixiQhXBUW1xAUCZKA9JAIbDAUJAeEzgAAKCRCxiQhXBUW1xAA+AQCwrnCmsBxgpqpBPRwqGUY20YHzGsDfkTIsgnyEjq6t2QD/S0ny+FaJAEXOFU/HTZ84iT2wXoXdeE3jtjycLO+akww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:ARqkbLjknU3g+EOr1EzR3p3uW+JEW80BrdIiOwn/qMTYIWOdWs2
 g2vYGhjjzn1kxtA/SkkkfzQENnURb+XbI4189DAwEmo6Syj4x30DT0ANZ74XDhiEyIWig2k
 l4W5lGdV+pGZzPsatsq4A4KaSEFTxbie+bY6iIrYjeo9Tdk6eUVxG34DFRJjfX53DVzmKYx
 shlg1oU05CCgRhWrCPjWg==
UI-OutboundReport: notjunk:1;M01:P0:zYnSjV9BL6k=;AWQhsNzsDJW34ZQFl4t8WYlLWZF
 NkhAIY6WT4rMAeKZe70O8uw2gGfq0GotimN3SxDF9uR+DSmqAm2wyIQkKt1eAzHFnpo9+RFWR
 uiIJ6WHFYVF3d4XLwzbjttIeNUpYZZj4KN6WDDz+aBEiXJMS9Be0SOvW1COY9QRCkmrAdHcEs
 /eYM7fZPZXyqehO910cZMwlaixyHxE5dLOlFMYIobcnPhjT74lr8zeuPeWCtKvCsxV3tF9n1M
 L+XPAkt3bu6H2VMPpXIIGN/gc8PUWmAf5LQSMnUbeIXyF8W6SQuUEqEYCTcbNO50iwaBnz7E5
 lXD/lzoGPEDlK7OOxAWbf9USXFzAYyKWhDXDYwqKFFJw35q7jPWDi2LtfGxzE5Nue//DPqbjl
 smsbfHD6wgq5O7xsh5Hmq9VwLvKdrVDHVr+71hfNhULM/V/hvC/XtZ2T8bhuYpoNuO3C97ETw
 rE0ysoyNRl1Zkpo4lRBHw+VXHRJ5qNq+GhLIElu/I8x8GYPwG8nyvF/ScMkq6Pu6msIk3dpis
 vp2x0wV5hUstO2lR9kcuSbTdUHrVac3wkowbZwgpPqk4cFSpodlm1WxOnDlmc8rASK0CsbKE6
 QQP25vNHWTM3OnodohTHs2sKx3wUqvC0s8HOGOM55Av+ns4s/7HATGZLPWmWkN1BfMW8fdt59
 YE/Lt43LZhyd/wSzGkrZnYpSFw7K+OpqnQNiBXsUUwV+RQ7fWYYPV39liZL9mrxbNjnxAghDp
 cA2lWrxAsskPx2RfjMuMRXydlkgALbi3z/hQvAw3yWZzlPfUPVYbIYKNsyIW9pBuC4jmmOwQw
 RuWgpKoDmLmVoJghnKnEjkXGZjwdAWuTK6Eq2pbsExNKuFDzmCHKnQcdRzrtdKTztP231fiui
 1mWUAvWifnceA2gzwhqS5lRohHDEkWI4EuKUuW6uZxruYKe/ZKXASEspuuefpAzWl/vdN40ls
 wpKRAXDMJO3huISwbzX3xDq5O8U=

Hi,

would it make sense to move the HID human presence driver at
drivers/iio/light/hid-sensor-prox.c to the input system then? This
driver only checks for the "Biometric" (0x2004b0) and "Biometric: Human
Presence" (0x2004b1) HID usages. The former has a vendor defined value
range, the latter is defined as a boolean switch. See the HID Usage
Tables, section 21.1 and 21.6.

I take from this discussion that the input subsystem would make more
sense for the "Biometric: Human Presence" usage.

I just wanted to chime in as there seems to be some older precedent for
a binary sensor in the iio subsystem. I tried to get that sensor
working for the proximity sensor on my laptop last year.

Regards,
Philipp Jungkamp

On Sat, 2023-11-25 at 22:33 -0600, Jeff LaBundy wrote:
> Hi Sicelo and David,
>=20
> On Sat, Nov 18, 2023 at 06:09:18PM -0600, David Lechner wrote:
> > On Fri, Nov 17, 2023 at 12:22=E2=80=AFPM Sicelo <absicsz@gmail.com> wro=
te:
> > >=20
> > > Hi
> > >=20
> > > Some phones have 1-bit proximity sensors, which simply toggle a
> > > GPIO
> > > line to indicate that an object is near or far. Thresholds are
> > > set at
> > > hardware level. One such sensor is OSRAM SFH 7741 [1], which is
> > > used on
> > > the Nokia N900.
> > >=20
> > > It is currently exported over evdev, emitting the
> > > SW_FRONT_PROXIMITY key
> > > code [2].
> > >=20
> > > So the question is: should a new, general purpose iio-gpio driver
> > > be
> > > written, that would switch such a proximity sensor to the iio
> > > framework?
> > > Or evdev is really the best place to support it?
> > >=20
> > > There are a couple of people who are willing to write such an iio
> > > driver, if iio is the way to go.
> > >=20
> > > Regards,
> > > Sicelo
> > >=20
> > > [1]
> > > https://media.digikey.com/pdf/Data%20Sheets/Osram%20PDFs/SFH_7741.pdf
> > > [2]
> > > https://elixir.bootlin.com/linux/v6.6.1/source/arch/arm/boot/dts/ti/o=
map/omap3-n900.dts#L111
> > >=20
> > Since this is really a proximity switch (it is either on or off)
> > rather than measuring a proximity value over a continuous range, it
> > doesn't seem like a good fit for the iio subsystem. If the sensor
> > is
> > on a phone, then it is likely to detect human presence so the input
> > subsystem does seem like the right one for that application.
> >=20
> > More at
> > https://www.kernel.org/doc/html/latest/driver-api/iio/intro.html
> >=20
>=20
> I tend to agree; if there are only two discrete states as is the case
> for a
> GPIO, then this is technically a switch and not a sensor. Therefore,
> input
> seems like a better fit; that is just my $.02.
>=20
> FWIW, a similar discussion came up a few years ago in [1] and again
> the key
> differentiator was whether the output is discrete or continuous.
>=20
> Kind regards,
> Jeff LaBundy
>=20
> [1]
> https://lore.kernel.org/linux-iio/9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@re=
dhat.com/
>=20

