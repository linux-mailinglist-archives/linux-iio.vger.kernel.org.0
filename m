Return-Path: <linux-iio+bounces-23550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35815B3D4E7
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 21:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CF11740F8
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D0274B5E;
	Sun, 31 Aug 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="I+6KaZeX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA164273803;
	Sun, 31 Aug 2025 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668209; cv=none; b=s7JKYAhXNl7Nu7m1OVHV7L1Gl42hWXjMBnFTmuxhH1VvH9cB54s8QlLtMwhax1rK2HqiJMFZ/cqiNnzuO87QbD/gJ2F5/JTr0KBt6A8Parlk0qaHgFmjSECUIUU3b96TPILZQ14wyT5UwtYg0ll10n7T3i6c7OWU5JnhjTHuleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668209; c=relaxed/simple;
	bh=oM5MoG/bN7oPb4wrM0zWOkfzHtwe1vh++4CXI87kwRs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GG28c4diPJ2BN30NUFXP0rhc1/4/g1m3vrdlF2XqZyfuPpjyrxqYBMlpI6ZBVmDTwfb8uc4dQ1YqxcagvOMLVPvJJUsRNkwEkTbvErkTjoxXCQQqFPaAQINkNpe7ZwDKQlwzAGfKEGT7hfpLgLfH9pt8AgTiCJB1goz6hUVQ9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=I+6KaZeX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756668190; x=1757272990; i=markus.elfring@web.de;
	bh=Eyula4qI44OjENAzzelKzeqPyvUD7Nt66+EEFFfY8ow=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I+6KaZeXWPzkQOE0sZCA1oApT4YxE6/YHM8PnOop/YytlpC9CciPRPLGJitXz3bj
	 2ttAVM1jWPA4ZTQjLDKE6007v8oxlVM/tAR5deIe2vk/qMjRUl2HoZVP1ROZSvk0u
	 kqsbhOelTI1DXB4rNKweef7st2cswX+9KuuXWXMzQKUgShZ2q9EHZ0iMZj+MfbMnV
	 b4mf5JgfszLph9yfcPX8TVt2MtooMmVEZdWuT9TGBTuNA2zi3gR1vJqmPdppY/l0E
	 2bJVgR24Aw9t3HBF+CHuxC+yqcMT4+X0Mg2xdOijV/cbeqYmT8J5/ataUWkHSjUxU
	 +QutKu33k58YGb+2sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.249]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbkSI-1uL8762Gcg-00fKPt; Sun, 31
 Aug 2025 21:23:10 +0200
Message-ID: <33ca2805-aa52-4b27-9fa9-ec582b7129f2@web.de>
Date: Sun, 31 Aug 2025 21:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bharadwaj Raju <bharadwaj.raju777@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250831-icm20948-v1-5-1fe560a38de4@gmail.com>
Subject: Re: [PATCH 5/5] iio: imu: icm20948: add runtime power management
 support
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250831-icm20948-v1-5-1fe560a38de4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vDSAPpkXhJTvP7VrI58WEXmHvqtrxU2YE6yqyespCY2jQ4vguhp
 bzwVVe8zhp7+mnvP50FmehgC/0tG01BwLNh1d20i2MjWLH/Dg508uaiGbCI1LOWyJi+eX1X
 OGdmTy7OI+o4xvVKbzAor4vQ7bRk/QJv3WtHmW1e/s5dd6BFxWwnZM/h3tySe5G14iuDRgQ
 DqeKdhS0Jwwh84DZt0meQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HTU3R5C8XOc=;7ge0XNlhmD6mOoaQ69Tqp0M/JsT
 sxAI4+zxDbdw0cfmFJ/vCmVcHhE0Bk/NBg+KJQXxvX8vvfVl9GU2SKhaexH8OxM4bwRbe1zoW
 IfyRGY3N/wyGC9/2zkiWmiXL0pyDPwmWKtbDizr4vri9UBiwCRASSPu9XUXPUUZuXSoCTzGrP
 6rgYGQjIGhUA2mO9iYUu2ez7od5hOfCTqo7F6z+VUZQo/OgG6l61Dg7Nj9CkfTRcoB7isSNzw
 O+6cIj8O9AxdGlZZPPz8zkuYV7dA8/MvocHKkysQrQ2nxTZWK788bKvE7CPA++EJivoI7dDYY
 9klQpYfdXzd9QYl2IpH43NlNUYvWoCnrKMG6YN7l/Vffl5+DWS6rHQa3ojDZdDg0JW0WCEBIz
 6rrk6Y/eYbSaWv3OmPAy/WyO1hFwph/Idcx3i5bUmk3R1Xj3/GEHbv3GQ7STsCvog7R0rHO+/
 8aVS8b9TKTS431TTw2n6DErzqAPnc2aX2PFbko/83W9K1Qt8uDHczzALvy0hY+rokGt64gM5O
 VmPl1RNkszw+0pbdrse73D6RdZ5aPN7F+AeNxNpgJRVi84nv7A3TaJObPSGeUHiN0UT6xxZMf
 yHMcTh+mP+RSUE5fstcyrF2pnKNWhWuUsKWWDEmS04oIf0Dfg+3fpcCaHkUo07uxqbWGvDLOw
 rkFvVh6Q5/vRyEhUmyk1Gh6DM7fCwCRddjEuhPlMUls3n64E0ghFssFK/+cwOjxZK/hE+GwL/
 n3dGdipSBnqnzQpTWWwFZ9S6p/ELJfYaQAqhsY+bQF+XtHj3G/5wnwkrm67uWFnPj+NxQJ2s5
 TSJXVH8XMBj3tLpNgg+1cXtUai4+kF66rMiJjV86kP0ODpMlVA3o1p/UNwwHhLLroS9/LoRzY
 /D1e1dc5cK5KxEuiRcwdn0laMyokwrDoAPAzWjzmL2bTwK8j9eYa8SQpuyblrCb6OOySwKe9B
 zu7RfpSNGreA5FtWtK5LEQ6iaqC5OPp+ZDZqw56XNX0PZMCE4scHixi/TGpdDcZZP8awh8KtX
 UtIfYVTTMTy0h8SFquw9V86qmB8Oz1l1J39ccuDFUN6pzLuWtJxCOnTmgvWcKTa1i8qxW9LXH
 1nPq9DrnKZCJsLJPTkRyhaMFgcmE6qdIEG5ln8b64vzV7dvj1BTthfNHmQGfudDt6UJjBHbUh
 NohsChCgRc0VTqL2/Z74Z5mmXCsp4kZVPXG0vlGhA2aWMM7NbDbZfUF9s1lytbbTc+I/Gl8us
 ftUGGpRjRySDk+UvBQZOIQ+kdPO8uOLMi83CVVXZi5N9Y/rQDCwr/+EOz/XfGmmLgVMTmMRjq
 tvMUUqmhpPKvsaDRLBAnBYIQTAeZnsKCSG5y9HZ2nssaPNukIlc9C12eMFD0do22ALTw+CRJ2
 p9fQ9Oe7pyx9pQeKRozMifTJtesX4cv6cXIt6vk5zbfvkkLIh6LcVB/IMdD71hoNO3j9nPetx
 oOZ+IQuLvNaNRdb1S5LKKwwnndGEH2Tn4i5MbgBL2D+wL2qbC7cKUylm3Y6YgXJ+tU+zutgDD
 qi/K7Yy2rxodSSF1kheFtcZWp1JtH68UJC2O2q0735OoU/PCCpbh17edd1jlWa44HG7CecAJS
 HvBLqDcRjLmbRURDxQcHXD7APoNlDkrT0XsjZWCgf8u+pGStj2pnxj3f0F5e+bX/amtyO4vjF
 kJHIolH1yn4S8g9SGZa6IXEMu7W4Ls32pw729HvztZbEmlSPzaVMOeVLkp2+hjCGbSfBdR4yi
 U0YKHht9NzgKnF74ZQgb2aGlo8914PAsrhZua6LyOj85HdNTYQl9LKfMIsyLcyyDfl18lO0Ap
 VAd8SuV/MNfwkyPQ50GnfjadrGuBw0Fc3ftKsS5FCxqCx0orY1qKiBMNP4SGwYaplHBAXrXx/
 gavzeybwo3xMSTfKB1p5cUMIYM2TPiGAIbpEEZcwHZuLiUAZ3QsjWbQwJH9f8hHH54LFfsQ20
 rZVkqhOwrkeDGn//Sg27EZGlvehpWQRfKBeKnFjQR6E3sZlhYWlE/0FVLGCVf9AiMW+uU4W1U
 OsW377Kw1my4TjGpPwdH7dluvZoDUadh8T4sXWRQS6gkRv7jAheIbAqfp25DHQaObJ6QYFCxb
 GzlZgMa4ImdKbO8LlvBRj4YeQ6ypowX2CLHu0w0vOCy7sCraRHW/6uagQbcONmArAC2UtEusH
 b1h3Fxakz7haUh88mgNRu8DQAMSUDOLFKfyccynYAP/BBrUaepAmpTeeCLw6rhjcBsC4E5kk4
 7yflm6wdQrI8xdi9fG4WaZErKkIf49cqwqucsgzv5lK2B/6CODHPKBewYpwPOyRmSmRkvuP5v
 JlQpRBZ5Jp4o9sIGBfUMjfnBV74yswE2lR8b0zPAvDsf2cAjEAOHBalQCZomHfhHIoa9qitQx
 zWqW9iGxBxAfdD/3uRAyBr76jPpyYQsObHWclNUvEH02EU3pLsITtjE4HDGRqr/T+0DKVeKKX
 +ZaXlsN5K12Zy1A+RYpfRGJuGuwwpXsIwmphmu3vPiyEQ/JnQdK+Wf7C6DPccIPNwjrO25nJ6
 m2wpoZklbX5w8PvtuzwPK7NQppsellj8VnLtmZSiN9Phv446wpymX4SFZq40CINUmc+ByZHm/
 OaGcaI6z4/xgBe7HGD3L9kxxlSRmISHkSnGHkLRjmsuBmgbcDPQO5+dlaIUjRDXv9D+TxL3MX
 dF/BvuaJeMpjAuiBaCykBsDiN+cPtZGtZghPVgmZ81qki1sjrUzVUfCuPolZtLsRrYGAzPf6d
 QCgQXc5K3676i4v9Xu827EiMB8eDx+1uYieA35dlc1PAoRmm4kB2DWUU/XScNjFQ3fIWZIaDd
 TP83WAWUOsOQgsjrSZtmfs5Fv1OuDIJnbaD2//u60sgLF186eGyeMp3k/Vek3Pr4EmXrns4Tw
 1Zevu5hcE4vdBSRCfSkOeZ6CcrkC86eKlGyAmDZiYpHIcYB6XoQ6MS9lfFe+xgjE1ke8mH+n1
 AchBSIj5HwkZcTJTTdRO6zYsKAH87PpdmBUYeMZ8rAl6ddaOU7YQHwTX4oZ7XfDRslH4Q8hQT
 0TAnA+95hLsq90Al5kUbAIFBLHwR5J2jyuoZjSeQ8TnSyuVJsjBKtb9PrifZLP5Gq/DyaBCBE
 +m2h213W8SQa/nZjOZ8cxExMWKY5nzzKlUN0mBG80nJrOLtXaZc8E8k8Je02tIg9FJNLRUHkz
 lLMj/9BYDc7KLulduuEM5KFBOE3mAgBu6m2HLaN2x62Dx+UWRLP+EFcV9E3JjLvMjKkmhAXWj
 zB3u5PHjasWu3Xn3ilqXWMePRZmLWjutParfrtOK8GcbIoFXu0kEGXyKHqO+cS3Q/Dr63UZfy
 Ael6BLBdADvP3dy8WXLWDVTfZVq3wtXRz2i2J2l5x6s+YDKDfoUiImR10ufFj72HAhroxeTRM
 c9jWHrxIKflJDTSzmDlow8oTd0WOGNV0RtwsLXomeoF76pH1G+UWFmlM/0ZwT9pE3Fx639U4F
 +O23ob49VpaOJlnngz9YcqkwxGRJzjoeY08bs1s28yEuof2EKe9AS2Dco88DAytCpMUTK8x57
 J3gzPS1YNFCJFlO4DVgOnNLFBb+qk8+3qt5+rXyF5He7td6rjvsqWtQNluGq4RW3fBz2DSjlp
 iBAJRWCqVZxGMX7Gzu6NDR3rFdHcGny3beJ+xw7CuecuA5awXJCk38T465X85kvtybCVa0tsy
 2T2Ct2sh+SvGO5po+TkWchi9eJtkQqdo/1of3gItYLnCr2e6rHaByWOxEoL/Ma6wGaJnj8d9m
 P/lyyPb7YNsZpn89aimzvm9evDIt9vU5LtkskSTGSyJfZXZGOFFITybyCFNG58sj+FkyzDZIc
 vBIHRclYBoAbsP4XCsZ4/6ZBu2csx8ZSUGZSlT43/lG3wCTREKTL8t0PU8FKCCUunOCG+r2TQ
 yJ5Ja0tZudZwfFj0XO7HPXdGTWFT83iEqC/eKvs37pDcWrz1c5rkWEsv0kANVEY0BeUEaFX+K
 ORqwU0vuiW0ySJfL6Xp26+mB8XOC15FPRjdAHJRRR1uG4CR2S69DjcoZddmI+AxfcLP0T9Vt8
 lCmcd+v04CInm9j7LHCOMLxAzIOnoLno9x8GWR8urBHimb0zyMPQN/nxZczV7m8aH0hQKtNj2
 /1YmzCtC9pjTVKYJ/eY+DJAZs/X9OZZLkkxi8qoUl4rnVf39OLK1DtptwqCquLcDJXd5kuToS
 2/MCm3N1E4yQFMrYgAYHKRHsjmR//bxx0VJc0c8wkaMFARjBA8SW7XU0Kxhud+idYi/wyWdd1
 S2rkP40JDmdPT2DJS3oBqhbEh54e0g9OYio6gwQXCC4Nc6+5HH6IcqcrKCeitMj3V4MJjidp3
 9ctTNPgk6koZhXhCJZ1mS9aZiWanUqgyJU5NwXQqrBKiX0d8Xe62sIJt/ApAmy+k1b3toYC5i
 p8vDMa7sgzxvhGfYYcHFdYo/9qECxejmNcmT8qLNpsZMVtA1paGSOl0EQTl8bfW6xrmp6IHtJ
 X8z/YsNp3907JqDGoEMkhQ96umBjZXrffcImJAsb1SMJSnqxLKSAn/XR1FuDk0ODdKbz3uC2S
 r/Sce7f6lAssU+KQms1zPLN4+fGzgYkgf6eA1L5fycb3zAyGeauad2sxv0YxkEASaV1yQBi1q
 edGBDN9sV638FRKzZPbUTKpW1BFJPPpxxZ5c780cOYXEKvuiCXSv3ZFknj2VVoUfOl7wKxTiJ
 MYbz0H5u4eDwPT0mBXHK4p57fC58aKs4Uzoe4rHi61FMCwgycDb2C2QXHqpWRzfgGShNv0UpR
 WszGtxYhvEwHTIqy1rkbB/IAaiJ5ZiXzq6VNzOoQg==

=E2=80=A6
> @@ -24,17 +24,24 @@ static const struct iio_chan_spec
>  static int inv_icm20948_temp_read_sensor(struct inv_icm20948_state *sta=
te,
>  					 s16 *temp)
>  {
> -	guard(mutex)(&state->lock);
> +	int ret;
> +
> +	pm_runtime_get_sync(state->dev);
> +	mutex_lock(&state->lock);
> =20
>  	__be16 raw;
> -	int ret =3D regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA=
,
> +	ret =3D regmap_bulk_read(state->regmap, INV_ICM20948_REG_TEMP_DATA,
>  				   &raw, sizeof(raw));
>  	if (ret)
> -		return ret;
> +		goto out;
> =20
>  	*temp =3D __be16_to_cpu(raw);
> +	ret =3D 0;
> =20
> -	return 0;
> +out:
> +	mutex_unlock(&state->lock);
> +	pm_runtime_put_autosuspend(state->dev);
> +	return ret;
>  }
=E2=80=A6

Does anything hinder you with the continued application of scope-based res=
ource management
for such a function implementation?

Regards,
Markus

