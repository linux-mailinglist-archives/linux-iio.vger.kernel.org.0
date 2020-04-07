Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 591711A0D55
	for <lists+linux-iio@lfdr.de>; Tue,  7 Apr 2020 14:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGMNA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Apr 2020 08:13:00 -0400
Received: from mout.web.de ([217.72.192.78]:42511 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDGMNA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Apr 2020 08:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586261572;
        bh=8iZCvK4TfzgSSgAd8zxODHBnbqjB750pxDrttHZ7JU4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LLSDomx/1pYRA+CpGpFWZJDWMbNodJHF0FOOtdQ731K8g68jmFbgJOmZst3jAjzpw
         lwxoCUFLcJhHDKKtT6Dc2l4DWyHLUhVXYQmZTi2diYH6rC9cgD7CtYiXkEGhgQ8m7l
         q1YcTNEJYJ9gE/438rlhlkPAlEaUvWfq/nt0fWyw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.5.104]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYjO-1ipUI22pn0-00gaVH; Tue, 07
 Apr 2020 14:12:52 +0200
Subject: Re: [v2] iio: core: move 'indio_dev->info' null check first
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
References: <cb300eeb-6045-bd91-3e0e-902dd3b5d5d8@web.de>
 <3725f882accda683815f04c0eff0bb36c285fe62.camel@analog.com>
 <39d24c67-e83a-e414-e27e-041c7d5cea1a@web.de>
 <d25190f18a171d82f3300f00b00f50f62f636d28.camel@analog.com>
 <2db41c0869d24d18b70f9ff5d4311fb86187c3e6.camel@analog.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a1ae5805-6576-82cf-33c0-6fc4fd3512d8@web.de>
Date:   Tue, 7 Apr 2020 14:12:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2db41c0869d24d18b70f9ff5d4311fb86187c3e6.camel@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KtraC8ozH8jWcveqLZFaBGc8ur5lNLpYT2M6AeGtkczQuAu7TUp
 WgM4gdygWm+QjSeFR7nP20QmJKNcl7G+0RHhzd/3BgohGiWl5JCsXYEy48Aa9GqyksemKYV
 jksRgpgMCb89tpRzP3rkYwNMWT8BRcCXkCIsWsh56/R9OpWbTbD34ktNF3bbP0Mduhgi2tV
 RmG6vUt5FTRe2876Ss3Hg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VucKd0+vBr4=:qbB8Tppw3hFHRY4C7UaxX9
 dF5zzXq2Ao0ZtUXb0cl/oqPTc00Q3+VR4V2AX9EdRvDYJ4Ez0IRy3HCJ1Eo2rDfqEJeaWE+P/
 oq5WVJdiOGTW4PgnBOPbtXb/IHR+ywsuwkbyEptSVvOz/qUy++W63KLPtPT3TexUCoBlq67QP
 7mQC4FZZ0UNktQnx0axEqvQA8QCXA8VU48Ashjts8tWbQ9/xZlskfDQFxWPyjYQ3rt+MmYFDO
 9rwWJm2S98APeQBgx2ytzYf282O2tX0OrTuTz80qFwizq4w6FzInyaU7o4arbEuU/fko+qT6c
 oTcP2hBr8+hJItJeZUoCPxUMDSld3gkkXW7tplsaeSMcuCkuOySfogZhzbLjsdmb3Ak0IdPVs
 /CkdwfPdGl9cwEdzy6EoXD/OF+30jil8TzbdglWVY/tBvHqJxGcd/qEpCftR/kgCXSLKL5bIY
 7b2HqnTnEv06KGMy3+OcqJNtMl0jo/W4WpNHB/Iwd5dm16bbr8XMWwhtvLUp5Zp4/+DiaeCKX
 46XtL9hjxtroCeLzYtG6R4Ul4qHMLCAil5clfrIm+V6XRMtInp6Pbx/k7vKjbqi8s9sh3Et8G
 jvZcL95jlr33MFeNN99EaFobX/TO4jkbFjbPZZqgYA4G46Evqgjc8fGCYEdgUxKy5/PfFCgmi
 UYMwzYNVJO7ao5KQllwSB6iAn36y0p8FlurLPc/YtvwZFaI8eBbvEXC7EEBI5iHQCUwN7qWE4
 9K/lfTcZ/DjsttSikymi3sO+aZaOt964Mv1t0AZVSRBlDwFwGRvHiWZKpe9uCXx/Ib2yHEKRD
 cRSvbLfPFMSFsLycgCJk/8CBRWsjNIG4dHjNwCXj0tp+qJLFeDjFCdMATk4gVu3EwRmntRprT
 JKo/oy8wBQ9/YDoT9LUcAF279x4ujZzvcPsFLYwLkkNXFKt5oXaPyW/0WxVRtd8O5sBK8TzLo
 +WzHPRi7xJpgarpb3sAnN4rJ4WKENxmGV1cqOhrTgWcQhacCS5LzDyvdXHr2PxomhnE6wBW8e
 ZzTAtfSOzUCGEizF9JLFxGSYGDXuZ/SouJHFIXQlKXl8ygFVyGX4nZ6EIsvEKfDCLAymA3ZLh
 EmAXtSiffqo6ycS/8j09HebZEOIw12WCTye/2p0u6cB4/ODct+w4B7pWDKNBdxqDlVzzz9GCX
 xZwaY8OWXVt5m59eHEMmkrKCRDEci4oJYtP0V7DH6UIe21iZkNUrbiroRPRjSrS2wJxYUhS7X
 Bcn3yRWxT5NQmKpzi
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>     Doesn't fix anything.

You would like to change something for a specific reason.
Thus please omit this sentence.


>     Just moves this to be the first check, as it's very =E2=80=A6

Wording alternative:
Move a null pointer check to the beginning of this function implementation=
.


>     This is a minor optimization, since '__iio_device_register()' will w=
aste
>     fewer validation cycles in case 'indio_dev->info' is NULL.

How do you think about to use the text =E2=80=9Ciio: core: Improve input p=
arameter validation
in __iio_device_register()=E2=80=9D as a commit subject?

Regards,
Markus
