Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E394EA461
	for <lists+linux-iio@lfdr.de>; Tue, 29 Mar 2022 03:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiC2BFg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 21:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiC2BFe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 21:05:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A363E2
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 18:03:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u3so22672307wrg.3
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 18:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ut6/8hZdrXD6w/oKBdhI6ASQdLFjjPrfHdMT0KxbqNc=;
        b=Q9DxsFzTxtnXUjJcNfoqSwU9EeguB7NnHpw5VATApO+dkF19Zp4ihOwcB2UAo/1JFU
         XBS5X/KlGH1I3Nd3ZFGi/X10/Th52J3+oVVGrnMvIhGTM+BF+3QPVzD3oIm27UlbYZ/F
         VmkULRI8mIf2dwmCmyugT7/pDgy3Y7iwKY+iiR3oHFjXvmDzrnFC0fJTmRQR+c+hIuOS
         wtMw+/vPD+gh1Yb5LnAMspiO7NMQVyhSnaIDD/sqf4MnH5KjpWnKS/r346A1hN7PQeh+
         dnv+3P7n1xkUY9wBdhCpL2SYJne6+/V78bhQ9yGHSSzOlm8Cc+hvDZSsf/T0srxieAmy
         KQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ut6/8hZdrXD6w/oKBdhI6ASQdLFjjPrfHdMT0KxbqNc=;
        b=b8EPXaSCU4vCkU3zbsh/ITcQMe7eQHxiUjsK3YQkD9ssjmJx2LAP61J2Z8W4EzBHlW
         7tSiCstIGceo6/1m38fDNWIvjOqb0oVCUrEMK5jU6xDFZA3y9/3C+xJX+NDT0okJamdN
         Q/RATIwzm0p9FSQM4Z+3XT2oj8ZsG+qfFJzfzh0h+fHBaT97zNK8Kju70rHVcn/WmPrl
         zJ0RQvhFN7zkrALw8UkuAgk+5GIgwJhWTG1Aazq+94Rkjlu/N8nIIV/peA0pzLrPcQer
         BLP2REArMX7AGflA1nS5te+3PWE4Qf8AcSGwtRcBuAwturuLI1M9m38UEUOb5A29OAXq
         53PA==
X-Gm-Message-State: AOAM533z8JvtX7BXnu4Nn9Vk63LNGdHcktX1ibq3QnLzLj4KHApU1m9f
        d8So0J4rQ1V9BW0fT7jc5XF9W48TC+6GcawAvPgagNJ2vAIesA==
X-Google-Smtp-Source: ABdhPJxvJ3d/GmuzRjeOdM7wmWKMWpuGrDsteCLwFbaB+W4h9FhrTLk/XgrM3ri9JSdHR5ndo3Qxh74Ui2FQy3NPFA8=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr31129973ejc.636.1648515475429; Mon, 28
 Mar 2022 17:57:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:907:76b9:b0:6df:8386:dfcb with HTTP; Mon, 28 Mar 2022
 17:57:54 -0700 (PDT)
From:   TORGNY LEBENBERG <torgnylebenberg35@gmail.com>
Date:   Tue, 29 Mar 2022 01:57:54 +0100
Message-ID: <CACyUgj+ToDpgEhLK7JgEFYiYTfj_P7wgCscPQ7cQp+QK2MG8xQ@mail.gmail.com>
Subject: CONFIDENTIAL
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:441 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [torgnylebenberg35[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [torgnylebenberg35[at]gmail.com]
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.0 T_US_DOLLARS_3 BODY: Mentions millions of $ ($NN,NNN,NNN.NN)
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear Friend,


I'm Dr. Torgny Lebenberg. Contacting you in regards to a Claim of
(Eighteen Million Two Hundred Thousand Dollars) $18,200,000.00
connecting you to my late client.


Kindly respond swiftly.


DR. TORGNY LEBENBERG

LEBENBERG ADVOKATBYR=C3=85 AB.

Attorney at Law; LL.M.; Partner

Address: Grev Turegatan 44, 114 38

Stockholm,Sweden.
