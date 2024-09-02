Return-Path: <linux-iio+bounces-8981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A368B96862C
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C811F227E5
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1A18592F;
	Mon,  2 Sep 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MjlEB9Zn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6113B2A8;
	Mon,  2 Sep 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725276388; cv=none; b=qApbilcO4cXOJEdFa75Z1l3Vrr9F+8NaS8HtAWmv6N7v7Who4R638BjDK5KMq6WPp55uWRdMZZzoOjFtGFNPyoJ//70GU2rLsqZLU9IkyIl6vqH0MtP3op0nEB9eZypJAIvtWU7fDzH07ZW79VCBHdwrCLLO9RtS8RHeLllf0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725276388; c=relaxed/simple;
	bh=yc93DkTwkPu1XtVmy+hZb0mOhWjy2fEGE62jH04ltfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKZrqlicink37T5CU4lJ84DMzS+AVLzg0keUNrhDY2bIBlLyhc9mRNKqjSeggdYdGRp+EZ6V1yGc+4KDCV8WH+Hr4JjpM3wjHx5LgX9uqoHzQAFwy4qYjmVpgo22WoavRC8fwY/3GKdHOTjYA1zDG3UtdvYvilOcLypKYAJO4+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=MjlEB9Zn; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725276372; x=1725881172; i=markus.elfring@web.de;
	bh=yc93DkTwkPu1XtVmy+hZb0mOhWjy2fEGE62jH04ltfo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MjlEB9ZnBGZABCneEeKp/js0zule7jM5nyw8KuwhRHECem6HH7RIAAiNxiSMERvE
	 4jSY5Y8xV/isMnaHyotBjdQsl98Ss/4X6oNL4P6MdGmXvujUUXqTDt0R3tQaKKXAs
	 9Ga1y2/2GmnNzBorPVFP8m82GgFsM+6u9EjbmLN0mCvUxGFJPjH/m70fNdScX6Pxf
	 sN5v3x/g9eWBzBj0KaJu+AlQXA0zrWVFF0ROBH5mga6T39yoKrNv9J9gu/DAzqptD
	 EYCmH/SM3VsA7lsoyY7XopYLryVo2N6BFcOuDFCsBkc33fw2SEF6F2kBWHa4jtO6b
	 M2mghvvDnSUqa7gJ0A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ml4B4-1sLfRA2L5o-00gAn0; Mon, 02
 Sep 2024 13:20:28 +0200
Message-ID: <42eb1dd6-f070-4f81-9959-fdad2598b7f2@web.de>
Date: Mon, 2 Sep 2024 13:20:11 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Gyeyoung Baek <gye976@gmail.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
References: <20240901091214.15199-1-gye976@gmail.com>
 <533802b3-3034-4b7c-b903-72608917e2f0@web.de>
 <CAKbEznv-TmCr2FAodrM2SKK5A5pbV9p5-OvXPdmuk_4xXmh=Rw@mail.gmail.com>
 <7b827ee0-9116-4e8c-96e1-1fa5f7267f33@web.de>
 <CAKbEznu=+Bkw4kmoo7qG9h2wM=2XV54j_SYzHMAH1uWhtUPCvg@mail.gmail.com>
 <3c60e167-7815-49c8-89f1-fe1139879d6b@web.de>
 <CAKbEznvpazyV905CFOp_sDs+S=ihhXe2QH=Gc38oitjFFKOW=A@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAKbEznvpazyV905CFOp_sDs+S=ihhXe2QH=Gc38oitjFFKOW=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3UusnGLyfD1UxdTEg7gZmO6CNYcyC3g/kfK0AH2yKXqxY0PgQUx
 ZvQ0EOuDmaZKqthoVzwJ/DaBh9v7wOmYvBuB0WS0xZU79KjQb48Y42eZgZOveALTJnUmWbp
 Nxq9O8v1XaR5h33EmT4yGBPN7cqhCbUdPEtfyVhuUASd3a4jjjyQ/EcsTvOCf94CC7v1eWV
 Jp54WaNMtE0SOVPyZYX8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wL0/GlDqSMI=;JgOPVlN8aLPgx0qTBd6kd9nGvv2
 suAjD24rNFQC6pwXZOy/4zOIBtvmEUo2R0XAbEenKE4lv7KR2vXl24YEz7BfedgDaKon3eZbW
 1pco15ASSPjvmiKhgeK8w65grKbtYJkc2xX1oqPkPe/q6utVccBE0DsSCT4XBxTetn7zTAB3J
 XDPFFByz0S0IRQ92L9sve+03tfjUXEm5wY7ehEB0jJJhqA4I0PQHG1yY3V2vxsD/Em2OWx/Yf
 2tpQQGEnyx20f9UGgz/SnjS0qnGGQ5LhEQDfJfyCgj97ZVg3DVnwoeRzFCfIjf+bw7EBkLCnj
 MeQrJtFqiEA4OdOSSXhFoGuUraqZP7nmMkVnM1xgDIvbtnRFg4/HAszkyehClleyjVfJc5ye1
 AglPhLa0GcBN+IQ6bzUMiJRjvxOCSr4DU17eCVZjpaKg3soxUjBT2TljYkXbCgPiTecs5DW2t
 n0jn2qeDxyuo6DjqNeZLD4zb+l4UvjAhuwfzbgg3V8F4dZsXoeAC9CwqTFRHZa2pN5rHoKTfe
 p8dFBqzfDtW5AwltjvAu3Ish2hO7h/SuH3A67J6UD63A7vrXTHlzpGA5BN6dsxkY6oP/vgIvm
 lUAzAwjSJCIACi7DsihKWk8psXaMEUvsHpzpE3eyvTEUua3Qe2URWpX/G7Ym057PDVKV2u4X2
 E5zpUdqODU68hoEnrICMiWaW9GRgKfFRi1bnnqYwBVhHLJld5c4ZZY6IsEM5v2rDZPclX1naF
 S//RSBHe66/6uLk3AjMxFYT9/mfymYMaQQZqe+mGuzW+GxgkLnaXoPv/FytLsZbv3fEaPEHJD
 203CUBTJ0A9/Ct2KcAXhIrSA==

> =E2=80=A6, But I just suggested a minor thing as,

This suggestion can trigger further patch review consequences.


> and since the maintainer made the decision and approved,

How did you get such an impression?


> I did not feel the need to go any further.

There are other software design options to take better into account
for further development considerations (according to the original control =
flow).

Regards,
Markus

