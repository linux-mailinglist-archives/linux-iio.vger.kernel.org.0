Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BB599241
	for <lists+linux-iio@lfdr.de>; Fri, 19 Aug 2022 03:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237364AbiHSBHX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Aug 2022 21:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSBHW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2022 21:07:22 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E6DB729E
        for <linux-iio@vger.kernel.org>; Thu, 18 Aug 2022 18:07:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q18so2206136ljg.12
        for <linux-iio@vger.kernel.org>; Thu, 18 Aug 2022 18:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=zBgp779WqhreJixwzCa1lDAelVYJN0lnI11zJWZf/zQ=;
        b=UvWaRmScRnLr7K10uDbNZPspWGw94RTjv023vUEaJXXMIKfdgyQtWYQH79DJLx9a2/
         lyo9ZVk70gJqgZYGMAbQLDys+W3KqOhex0M/9wWlsn/oEWScAK148DrOC+ggMPqL7+qC
         S+efvbbHCJ/hy6saFn4z/0X/kEWmpyT8MEY3yyOYBXlNZ2uD7Kgckr8riI8NrUzj7C5y
         YIww/EQSmQVczhpCh7pdUgZN6SXA8/K/oaHYWmLM1aNinHdLokVbfG1vBa71H9kKYQO+
         hv0hn5aymhew15x9bcqb9OwaD3ZM8lsLRaRUxZM87GsEKDFxNA8LImNkJhL6o3m+zisf
         6bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zBgp779WqhreJixwzCa1lDAelVYJN0lnI11zJWZf/zQ=;
        b=CO4SJoIUiA2Gwd/tsIzVCMcyeyx1nbou63nTuKO0aNTbLPcjNWDANQWeHe7TEo+dko
         MDJCiXDvwTXV+VbkoYPi/G92+W5x6x1Wo5cShzNJu9i+tsEP5qTVU6C4puLGe3pHbDma
         A4p2xxqmdPsrDVlNILGFdUYdFUHx/rzgnOgkKkBjOJi5M3gftQJnKBVoE85EubqEApOs
         /wUVe7Dgh2aktdEA6gdEJPCnB/aZwP8bSsQkJN1RNGQM66DZ9x7pFrGHrhOFyQKqX0ko
         1XejTj3/A3l578yM5lNWgEYcKbXPte/cL/ZBHY22xehMDWsv/kcHSUiGPfZ9WPme3sKi
         j2Dw==
X-Gm-Message-State: ACgBeo2fkHzg+7HGGA2Y/5QtcCafrnafCGZZRqeGc8iF5l2rqoG+oipW
        XjSSnTSrq2uPdHdZ/R6zZFD3uYJQ0b5rZGAJU7M=
X-Google-Smtp-Source: AA6agR75W0fTdsQNMvlW1BpVoNasykxdXR4KqX8XZ2qaAM1gpdl/Aum6g+RAzjBVbTQVNNm5tUlbNU9YrnKVtSf67iE=
X-Received: by 2002:a05:651c:222:b0:25e:4ae2:c5ae with SMTP id
 z2-20020a05651c022200b0025e4ae2c5aemr1518361ljn.440.1660871239553; Thu, 18
 Aug 2022 18:07:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:d9c4:0:b0:1ff:3f03:e5d5 with HTTP; Thu, 18 Aug 2022
 18:07:18 -0700 (PDT)
Reply-To: mrs.sophealjonathan@yahoo.com
From:   "Mrs.Sopheal Jonathan" <dkabore986@gmail.com>
Date:   Thu, 18 Aug 2022 18:07:18 -0700
Message-ID: <CAEVjOOB9f_bN=zUne+k4ZNo96v8PPtpGQ0CiW67FLA0iiS1Xyg@mail.gmail.com>
Subject: THIS IS MY WISH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dkabore986[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dkabore986[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how
dealing with Gold Exportation.I Am from Us California
I have a charitable and unfufilment

project that am about to handover to you, if you are interested please
Reply
hope to hear from you.
Regard
Mrs. Sopheia jonathan
