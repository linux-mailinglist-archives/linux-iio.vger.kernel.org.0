Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9E3772847
	for <lists+linux-iio@lfdr.de>; Mon,  7 Aug 2023 16:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHGOzV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Aug 2023 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHGOzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Aug 2023 10:55:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534AF10CA
        for <linux-iio@vger.kernel.org>; Mon,  7 Aug 2023 07:55:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3fe23319695so13135375e9.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Aug 2023 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691420117; x=1692024917;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K4byt9FnkD1Ok70cPMi/xvss6MNYZ6cLFDt36MKgtw=;
        b=hm7IjC7tYC7048TSqVO8R9yjlZ9VdUsMR9YQSs8ikPvgGDNZ6zfBzFSMtXF71/xUaB
         V8iub/zqtHnPyZp4Y003KGnBuQJcG1cOFO+lIdc3u2tCewDw1hWWRr+zFnDdDQVOWRHa
         NZw8hioQUawQ3ii2WC7dWh1Am9F3WmmJJR9+Jtyo+e/l7xtYjx63swuxX1+h9qJQvpCe
         Beudh/ED5Mv7m75zoZjRrHGtdUjg0yXbPWYOb0ukZIixYxN4f7mD1PiiQ/8jLAremXas
         3ik+J9TYDChmXF6FjTyWViFDYg8ruKUf8vq7FHaZ3rThmak1qMnIQt4MHRElSAinRLH3
         OV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691420117; x=1692024917;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3K4byt9FnkD1Ok70cPMi/xvss6MNYZ6cLFDt36MKgtw=;
        b=WCUwLsjJfRWh4fO4AnBgZVIcD0X03obuFnacZUwc3F9WQ4NfDvlUjFOG7cmFvOndB1
         ujJswPE9dfkFiffHKoXxf4Q3TEgR5+H5+TBkaxv/tMQ4PwRjFKl7PojMpcDXSSPxnyJT
         aUYvaAaAyLZVitCHiSEwtncNStE/MThHt07LUQOVXikQ8QP6nWSORYX72kJ040iKPZR0
         HVGgNsibkquO98+Az/brkd+XnYvopAh6A6MTBrUO6A2pfsnUUtR7RcMfmg/jjATonw6C
         AB8aabXtz0LwPHugKPevb5pB1IA6tHRSwYfBDDkC/7oU6necTHKqmQQmCmq75GPQPQ5e
         6wgQ==
X-Gm-Message-State: ABy/qLaTGzrMMh3+0COAt7/vtm6cCAIOjF5EAiDy53e9fACksqXcWBbY
        mpuu+i0sSCDr00+tpHJZCZUsP90SLo7HV9ESSgs=
X-Google-Smtp-Source: APBJJlFs0ETitEafB2A6pirc2mUCk/JLjnUo8ZZ1vjyJ6/pwsj+Hj8C2H1kPtcHMlBMK+W2gQxPMSLCAIPh39l2rMF8=
X-Received: by 2002:adf:fc0e:0:b0:317:3da0:7606 with SMTP id
 i14-20020adffc0e000000b003173da07606mr18815589wrr.4.1691420116397; Mon, 07
 Aug 2023 07:55:16 -0700 (PDT)
MIME-Version: 1.0
Sender: moritza919@gmail.com
Received: by 2002:adf:dc47:0:b0:317:e1f6:8104 with HTTP; Mon, 7 Aug 2023
 07:55:15 -0700 (PDT)
From:   Bambridge Chambers <bambridgechambers@gmail.com>
Date:   Mon, 7 Aug 2023 14:55:15 +0000
X-Google-Sender-Auth: B3xtGpqSJmP_m-LDihan1R0q0sQ
Message-ID: <CACZywftPerUb4g0H-3sX1ovuD1aKXkFptQJDWLiN=Tg2tcvNYw@mail.gmail.com>
Subject: Good day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [moritza919[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [moritza919[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 HK_SCAM No description available.
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Good day,

My name is Bambridge Chambers, I am a senior financial advisor in the
U.S/Canada. Small Business Administration Award Program. The amount of
USD 2,500,000.00 was paid to you by the U.S/Canadian. Small Business
Administration Award Program. This compensation is intended to help
reduce poverty in your country due to (COVID-19 DISASTER).Today a
power of attorney was forwarded to our office by two gentlemen, one of
whom is an American national name MR. Gord  Guttman by name, while the
other person is MR. Axel Pasternak, a Canadian citizen. These
gentlemen claimed to be your representative, and their power of
attorney said you are dead due to Corona virus disease.

They have set up an account to replace your information to claim your
$2,500,000.00 below is the new account they submitted:

BANK NAME: CHASE BANK BANKING ADDRESS: 195 AVENUE OF THE AMERICA NEW
YORK CITY, NY 10036ACCOUNT number: 0056000639 SWIFT CODE: 026002561

In all honesty, we are convinced of this issue because we sent you
multiple emails but no response and no call response, so we are
starting to believe that you are dead. Make a note of this email and
confirm:  If we do not read from you, we have no choice but to forward
the payment to the two gentlemen who claim to be your lawyer and your
next of kin. They are ready and willing to work with any requirement
required of them to deposit funds into their Chase bank account
instantly. That's why we suspected them, and since none of them have
your last name. Your prompt response is urgently
needed.

Thank You
