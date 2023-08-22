Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A013784F89
	for <lists+linux-iio@lfdr.de>; Wed, 23 Aug 2023 06:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjHWEKQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Aug 2023 00:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHWEKP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Aug 2023 00:10:15 -0400
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6212E46
        for <linux-iio@vger.kernel.org>; Tue, 22 Aug 2023 21:10:12 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-7c-64e571ba40f5
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 08.06.10987.AB175E46; Wed, 23 Aug 2023 07:40:58 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=HWq6pCUmzbXHZB5w3BGMSenVTMcweSQLxectz5ojKMkbOw4JAso4+edlS6mU+O6wB
          haGBCFL+r26yo5ack01Kehnw2b6KFiP5XlbsT+n0fYrYSOwrpT/ftvI/QmaplO4Fb
          GvyaUYqebw8EbT/Bb61mpxOIyX4xnkksIKIdwmQBk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=SPHRD/CRGhgfp06D9YsyKGY8y9ynyRAoGQNU+s+GipqXodena4P6rBq7V4Fe1F+g5
          S1R54Bypaa9MymKA6I6+IJSoBfYhaPXc4WoButM65EnNhWHArtLHiBoun5klZCGkM
          l98Tlvuy8edVrrkB57HJUDnBNg54hUjfyHHTpl+mc=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:02 +0500
Message-ID: <08.06.10987.AB175E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-iio@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:16 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsVyyUKGW3dX4dMUgxfbhCzmHXnH4sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAiseXLS7YuRi4OIYE9
        TBJL9ncxgjgsAquZJWacmsQIUsUi8JBZYtZxO4iqZkaJe419zCAJXgFrids3JrCA2MwCehI3
        pk5hg4gLSpyc+QQqri2xbOFroHoOIFtN4mtXCUhYWEBM4tO0ZewgYREBWYmZ3XogYTYBfYkV
        X5uh1qpKvDp3DWyikICUxMYr69kmMPLPQrJsFpJls5Asm4WwbAEjyypGieLK3ERgoCWb6CXn
        5xYnlhTr5aWW6BVkb2IEBuHpGk25HYxLLyUeYhTgYFTi4f257kmKEGtiGVDXIUYJDmYlEV7p
        7w9ThHhTEiurUovy44tKc1KLDzFKc7AoifPaCj1LFhJITyxJzU5NLUgtgskycXBKNTDyrDlu
        FrXsmM3BeKdci+BNHR0mU4J4Bf7dfvojxKdN6Gld7qQrH/unNyfKTd/3/fbem+37z7zf3imW
        aXjaLyq+0l3lTcu8vtmyDFt6Tv77IxHK8iAwjeXptaOPdKZfuH1P8zG3eJnkiZMfjOYxajBO
        WyxxNku/4mrz+fXSnaV/12z3ZpV06HNRYinOSDTUYi4qTgQABaAVWj4CAAA=
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_SPF_HELO_TEMPERROR SPF: test of HELO record failed
        *      (temperror)
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

