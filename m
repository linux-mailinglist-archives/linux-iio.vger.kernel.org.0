Return-Path: <linux-iio+bounces-23135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C890B31354
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE0CAE770B
	for <lists+linux-iio@lfdr.de>; Fri, 22 Aug 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622AB2882CA;
	Fri, 22 Aug 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha7rLTOI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EF2EB5A6;
	Fri, 22 Aug 2025 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854929; cv=none; b=S9eUPznixOqbkCBkwRSu6sj9fsGJRdT8eG+OGGphEpnyqMvfJ8B2Vdc3BsuuddgiVhmDxqK/qJwcCY1wY6DQjoS8kss7BGC+VXeQIjuwevhw4ywsT2s7I9GlYRBWTWYO1ZxAMK73mXCFsCecchx+0GOUBwejZYGpF5z+xC0Go4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854929; c=relaxed/simple;
	bh=OqlMfpxirxZlbM+EOIPx1jKbcg0mazAKdivQSHylYck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG051mVED5Bg6EiXQva1bpTQYpxHFSA35443ToNCSed0PbAR0fEEHQlexSTyE0JA0tbhBRnyDDhEaQnQ8NAWSUeknM76HjuUi/WOZiZ6PeESLPhqaD8353viK/yX5kpxxiSLrOrg1WzsQdW1GEmiAzMDn3HZ35lAt14bFu3c07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha7rLTOI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74381ff87fdso975685a34.2;
        Fri, 22 Aug 2025 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755854927; x=1756459727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqlMfpxirxZlbM+EOIPx1jKbcg0mazAKdivQSHylYck=;
        b=ha7rLTOIt0PXFNtB13L6moIxULIWcNPNAmwciEW7PfQUp4scchnxQzQgBiJt+TJEAm
         Kxy8O9zZHrzkp9lzzH/zWlV3lpfwoUTBpYbrQXPaQiHO2lUUzUBbvQLrqzSk599E9byL
         NLYD6g7dXbFrq8ZEZTruXd146bViaxJyu9UTAZUB7KAWSl9FJuPWDHlammNn++dAvrkj
         7j8Q7EloT4MwjIITEU9N+t+GJcGuj1DnCJRoV7W386qsOBNOt7oX1WitC7/1BPg/p/jV
         FC4ZJU96qaN/6pIPDixKYL70mMOj+7gxjbXsKmHBlYSn4duxyNDdrsos0IASIZ7nfBNg
         gwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854927; x=1756459727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqlMfpxirxZlbM+EOIPx1jKbcg0mazAKdivQSHylYck=;
        b=K1tnl3S8Bq+02WEkEjBiDV0ZpQ+w4BRyIAxEF/nKBtCM/LJIIO74LBPd2xgINuISzf
         aJSBqgykwKKRBQ1UWX5AYzuSWiVtVBLMnUFxNcUEetPvoE2Kozy1Ucy0OfE4gzPE5IVb
         jRTaWQ03FJnCuEUqWNJTwLP8IuT7cfqScCpVF/n2nO4B9+ZALy//0qBPMTxiHexEu6dE
         qhysYOuTR0kcyDiW+uNp+Hp9OhdBMSOCj9kLcpcT3XMiZj83hwvfNrLDdFfzaJGke97h
         mGfxWaqp0UQ4uOMvGw/F9NaqBRvogbwBd3c7uO7xP5t3NW2bk+nUv6yesIoLBbIf4yLp
         xkaA==
X-Forwarded-Encrypted: i=1; AJvYcCUUDrafeQY7etooKpXbS6sX9zL0c4/hKdn2EA4naVb1+5DUx5nOweanJ26gR43HKPV47PI+BQhw/9Y=@vger.kernel.org, AJvYcCXEp+1Pzr1uURfaq/mHNE9e4HNtwfKh36KdwK8BwW6/dPTGAnPgwOciWccb8bf0p/oIEH0NgfT40C5nWcEV@vger.kernel.org, AJvYcCXjHBT9Wb1KOwfIoWTwrn0f8Wtheob83ytkD7j3c9rJS4FKZM0T7xD6HzrBS1x2ErImnarA2OrHPutjRDExNRh01AY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8ywcAIjWZF2o72hmIAMU3CpX36KXNIloSTH0YrvpL34AXe9i
	gR8xpMDhyzWUD23QYtTEbeH3A1oFHnFIpYvEP6V8qShU07NtuXknExS78HqkKUc0Q0vgBU6sSaY
	nlWv/2K8W3/eqjUmUP9o7NQxB0vLC7j43dKBuuCw=
X-Gm-Gg: ASbGncvtMBOXHMbcyTipoAglDO4NG1ajk4xsWpO/WmKOVlXf1S52Aa8Gt2unx3narIj
	2G97iH+fVuadlfI98ioGyeUtdzZPbI9Ul0bBOqz/j2s7L06oTqLT2XJof/L+CIT3YXlTQHH0Yf9
	tRQg2T+QGN50pFGXRrZYpp8k1lN5nz3Pva1316p5Vd/ZqjWi8HkCpHoF4K2fdtnTH2vk24mFKdb
	GPzsKftcZYu
X-Google-Smtp-Source: AGHT+IG0WUhPdSZY22zjNFYLvLkRtJyOHuecSxMaftHRAg40biaWvqUVTZ0TEJKgzzIWavFPuLuDyvykjJqKjLkk/oI=
X-Received: by 2002:a05:6830:6007:b0:742:fd4c:53b5 with SMTP id
 46e09a7af769-745008e592emr1631143a34.4.1755854926647; Fri, 22 Aug 2025
 02:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-enomam_logs-v1-0-db87f2974552@gmail.com> <CAHp75VeTD5Y1bi-jYyfRnCPDfB4=WO+QF1uK5MSaSq=oUUMFdQ@mail.gmail.com>
In-Reply-To: <CAHp75VeTD5Y1bi-jYyfRnCPDfB4=WO+QF1uK5MSaSq=oUUMFdQ@mail.gmail.com>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 22 Aug 2025 14:58:34 +0530
X-Gm-Features: Ac12FXxMSIjWb7zWOXJ_ncO-BRx2eimh_ZSSxq_sHgWo2d3eJFCXvRVqNXXDoHg
Message-ID: <CAFmh=S3x+SsuW79MdN6gE66CSK7smvbBy=22j=c9jGVOns6PiA@mail.gmail.com>
Subject: Re: [PATCH 00/10] iio: Drop unnecessary -ENOMEM messages
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Support Opensource <support.opensource@diasemi.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Andreas Klinger <ak@it-klinger.de>, 
	Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:49=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> I don't understand. Don't you have a subscription to linux-iio@ ML?
> https://lore.kernel.org/linux-iio/CAHp75VdL9kV2fyi63zqPZnW4CaeYPmJ74tmGEg=
U=3DM7FSYBv0ww@mail.gmail.com/T/#t
> If you found something new, please base it on that series as it was
> already sent and reviewed.
Thanks. I do have subscription to linux-iio@ML and did check the patch
series you mentioned.
That patch series by Xichao Zhao removes dev_err_probe() for -ENOMEM
cases whereas
this series is targeting slightly different cleanup of removing the
plain dev_err() log messages
that are there for -ENOMEM.
As far as I can see, both the series are modifying completely
different driver files without overlapping changes.
Since the objectives are related but independent and addressing
different type of change, I thought to keep
these patches in different patch series and have clear differentiation.
Although to establish similarity it would have made more sense If I
would have added the link to that patch series here.
Thanks,
Dixit

