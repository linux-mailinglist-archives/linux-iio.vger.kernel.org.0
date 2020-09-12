Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AA926789C
	for <lists+linux-iio@lfdr.de>; Sat, 12 Sep 2020 09:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgILHpU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Sep 2020 03:45:20 -0400
Received: from sonic305-1.consmr.mail.bf2.yahoo.com ([74.6.133.40]:33818 "EHLO
        sonic305-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgILHpT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Sep 2020 03:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599896718; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dXRrSOzWlkHuuuGRGJ+0PwZJMJdM4rfWmlbvmX5UxhqqLk0UXSNC82V9B9iWfUjTd0oEHpx00fRU3aaH1MntekSx6X7BVxm4RZmtp+wed715TsYEFemUOff6P97DlPdv5fXcVHVrFywvSueB9n9t7YI2ZBJjk2t/lvIZwwSQFujm45HuM0dD6rWo833WSqtJwpzcRC5D+xtEldUPleHNTPHjSMpp8gplVXGcLmNZmrfSrZG9WeYa1WQQa/d9D7bfEf4YXsaJrKJpu1Q+6JDrjhqDVO31/KLbHPthY82bK78vz8BjjnbffSVpUcaDbuvCTN+/fLOTT7Q9uy1vZy3KNQ==
X-YMail-OSG: LLqBhJsVM1kZksikuGjxcP4eHwzfmsmq_ziipfJD6lkbLy0BqM0E0eXOXXkd.M2
 J0f_ImNIjMx71r7Gr3Dg18.v5WfsvT2QldapBVVcGcdiXhEUP7a.ZEgE7ncud5i5dmOMLlAoxOtW
 vkhxFtd3TLAODz8jOOWXAncS2nSqDJ63avdo9jDSE56NVstOsZ2aBmLhhMfftWP6LxZ9EanJYrJa
 eLPQaT6MMV7aP6U09F47VIayFNhvWTEfcAcBWr0vJFGpsAK_poFHCyNsbhBEnR.cOBqlPjHWRr2Z
 T.9QQ2nHNDE5xcyMARL6PQVj7h4phbDb.RsRcj.0ZMt9LUw4nd0DHA40K67eAE8VHhdFrjQvT7WN
 lHFfOCz_Kg.jKHq7iQsqmQhuN2BGDxHxWPAgGw6XbOXGkIyLxPRVefiNKiWBxQYjdmJFy9iqBFFp
 8gikfcyTg0bL4VpnS84TC3KSMj_fH2sQcGWed7aBy2Yy5C7KCyr6JT01c.vbJ_dGJ16r0a5JanSv
 tLPGZhuv..SqvpwMbiQfLz4QZMBBpH2sibq_mv7ip4BG7DgxKtmRmypOVbFlvd5_A0xKQy5eVnVu
 QT2JM7r5EK7G301pC6wDySb9560C6rdBiZ2OSOJF1CdUNq221.k4EmcS_3XGAfCL6A0CwkceNHvL
 _TVOSrrBsZc8GUI0zHSo9xbxXkiixY0tEcdEnGs7ZMBzTIaRNTKqKBsBWyy2xiaC72EAwpkrHoNQ
 WtWBAGaEEXnqGbh5mdDcG0yZZL6tEYsDDOBgC69Txk9no.Z4TcXhG5rxLabS68WQ_8mw_qIQNM5x
 vOSdj_hnpALVLo2JcroF6auJCJULWI3po5B7YZ995h6BVER.7flw6NVIcnNg36hYtUrG6E7CHukA
 8cvRGl7BlQ1hRLtgzZ7mV9HxBxRpPT_XNVQmVyADweLoZ9Zo1Ta001yFkjM0rSQ1OmP.DokJmhFt
 ciH47dKimoIxWM3CInHS424pWNu7BKncWXZgFOfS0uLdfm3gd8w8kPYTwOP9_SymE_cgELIvP1Sj
 Q0qyLNq0xErPhfkBOhB.hztN2UCbT32DdwoZR_VndF2o.9xoHKlt2K3r.AoA.TsXcBPCo173uIkl
 42KraxGzugoaK74EBpFnGoyIOYGBh4T5rm69Z9p6B5xFst0SrIy1lGm3pEJmkxKBB52d75wnjaJf
 Kc5VpYsWd4KpDZnkcG1QcAjkMydpT86A493th0M7WDnx5WM.7CUWxjXQ_oQJEnf0_q5vmh9i5q8F
 sXjv447CDgOEP4Kxm.Uiqm5WO15E7UWVu5K7SUq2CJ6Y75lQYmdNp4XFnIYw4hDiJPnXMZ7NxJT.
 D8YopthXldf4l.AYJwekf1k5Cge9zx.lI3UHgJJqQwpwONwpRqDe74dsyk_ukpE5EcnPw3uQioK_
 mkRulIQco0PnyjUR1Td.i78rCAziKOBcicuM.bslkcssY9.3LqVwGXVM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 12 Sep 2020 07:45:18 +0000
Date:   Sat, 12 Sep 2020 07:45:13 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <307770951.1372798.1599896713776@mail.yahoo.com>
Subject: BUSINESS ACHIEVEMENT FROM (Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <307770951.1372798.1599896713776.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.2; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
