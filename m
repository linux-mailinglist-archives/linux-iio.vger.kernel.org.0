Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520942050DB
	for <lists+linux-iio@lfdr.de>; Tue, 23 Jun 2020 13:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbgFWLg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Jun 2020 07:36:27 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:46025
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732520AbgFWLgK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Jun 2020 07:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592912169; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LEFtcysKmq/nCktPNrEGtOmF3EDRoRuM5Uc77tXVkbkuGtocWtOSFNKVohyUv7yB4WaNhcaKYIgBJ4s4iB/XKnrlyl+pceVbBOGIkawVuhtwHUKPw4W//oZ9sVqqJyal+J15zfhALl/hEDvLMPrUBJ6XZY+UZYfIziJAGdy/erNPrhYsyMYuH9zAH8+oDSPlvvD+mIy7IzklpdfI1DLyU0N4QpG9P2gBLXwaw1cahLtFUc8mUMUQDWLr3Xw8R8vRd6wbT9IRl5t6guTvVaDdeZPhAGdmNLCmfoWufGu/rQf1DLx1KbkZJ6zrcNaFEeGjQLhfJiXvaqEt0L0/xYqJfQ==
X-YMail-OSG: MW6nc80VM1mytE_t4Tk9WNEgTUex6BgMYxxXmqsCeNI3wYtli5I24.o09yi9Z3.
 8lZfAMZMaESPeJQkf5RCqGBwm7bsXvqHAfwV5VEf4uYOs2_1NwW5RasHl7SoOovz6yjptHOfH369
 FT17nfAlF3pWO7igtAiehtK43JQ9ZEbsqWD.NIS8_fwYHcundT0vWbwBX9BMKqMr06_G4FPgGv6h
 ZnOyYV_s0epElps5lmasZ14RZEcAjkWegHEvn_F0GIX1YoSrgezftFUGdOFxEk7pwRJlmXZc39FW
 I1QOCE575rGdHv7eWPZMBblGQM7ybggbQGLJh3suToPCKVueRBynN0.AMizzcDOqqORLv8e8.ZkO
 e3zvkQlltALFKIfugvWeg5XE8pXOtPJ5VherbnOJrFPUzaAW44xOg.Jv8Y8FH3iPgtpISslKHDm9
 dWOwLTXNF4F7JcXgwswoBTlw26kbZKDN.tzYoFa00hmn6O39ES_PTHSssp7sHM9DGyVXs7cB.y2f
 3S2q07TNiiYJML_0zILNWxAalTSZUkcYSF_OHT1vXk5c6b30xIKz1bkYaBZxDkJcPLmpx1NWuOom
 oSAeNxzrGYkGMPJe2ZWcdXX9pyFFP1zYaYryP6e5S7Q1yPAofZuq8H5fs3fCtZ.hY4NasAGKFknS
 xdO3IRz2.h46KUukp7r726MaZYW_h_4xvxpL2v57kdRwl.b33hvBAmjsqFbYJMCQ9dpHauBobmM9
 OlZUyWKYgDqpbrMi.dMMnPvfwxMQ_VAHdZyeq6N9Nl3pOR.ZNiUM9fwO5cIOUMFz5iSt8YWAebZy
 Mz7sw947pTaTXxBrQNHFbdGqoxtVeKsJAuapGFdoonBMrNZkoL6jKTZNPnro90neuIiqaelekzcA
 9WNbvkH61ETwjFJDO7u0NgQ0WNQIj.cblHjosiZzEasrLBIt5xkE1ozpKusnhsHzyar8oiWhgNbx
 NdoridPLJbAWUflnodUhkgcikA8I1_i0CaFp6U36qPH267nsNcqcUSqxHM19E6nPIgHLaDCvq._6
 SdfWJnulu.uL6FQQuQXlLpp0muFn4XqUuxof_mSf2a5GAOYT03qdjWllBvd3zYd.K2WOFQ3kPUYh
 gqdaGiAXkOmqw9Oc9G55qr80Z59g01iglv11Q3Fi0VJgSEBJd8E_rhrMcBGKzOgEHW.yeXZ60tpd
 F_4F.0U3TYW0GD.X1pTB5arYrZ51nRIgLW6pDo5nAbxczy8bm0brMaUm65KrZwBGzuQmr9hc1Qo4
 VORSTRb2FAmevFL5pMTtvmtBac2o41nLw.13UZR5wScWMRjEMqQiWYW_gSw7IR6HWyjqh
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 23 Jun 2020 11:36:09 +0000
Date:   Tue, 23 Jun 2020 11:36:09 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <2057754040.2331115.1592912169005@mail.yahoo.com>
Subject: BUSINESS FROM(Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2057754040.2331115.1592912169005.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
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
