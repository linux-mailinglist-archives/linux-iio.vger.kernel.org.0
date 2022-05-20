Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7F52E94D
	for <lists+linux-iio@lfdr.de>; Fri, 20 May 2022 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345013AbiETJsw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 May 2022 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiETJsw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 May 2022 05:48:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D1149ABD
        for <linux-iio@vger.kernel.org>; Fri, 20 May 2022 02:48:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id bd25-20020a05600c1f1900b0039485220e16so4754388wmb.0
        for <linux-iio@vger.kernel.org>; Fri, 20 May 2022 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=MtM9n+bQ3rIoECGMGIggB3xKbEl5WLKOSkc5IpE8oWmoWaqFohs8QvViFiuRZg+yme
         HA5Hc344xwHxipT18QjBMP5dn3BZZrAg/NW7h8VltOh2ZJMH6dny2E2Ma/f8CaB/7tv8
         YJPViLoL4GaaAaIksjUpBqi0CznFVWM/SuSmnLUPiX99HtSOMH+KSc/A1suFxDMM1g9q
         ZFjM+VchIwrU3BLscBq7OkhkDW/vDwyDqkHySB/hpFVX18G8jchHaEGMvv3MTzh3yKNK
         ZbmcyMGJvjcypNlPrZKM4E37SqsaPR9wlR+HqyfP8TUeqvQPC7SvwG5M3TO0H2pivHQx
         OSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=CSxd4g3groaRqbvh2/gCtdIh7tnOH3VOwLGae9TxMGAVlwF7vuwsFj4hKAmwTyHlF7
         Pl84RVS37eFeTd8NW7R5ph3DvAxyWwxFjQrxhJ5dWGJGE4vzNvSfTsauhgjiRSdxHWgl
         ReVS+m4pV2r3ll3kzwVE1ratAB6Gi/InQi/FBQ2gIzLDVvXZsoMHXXxOcV4JDCxWeTnK
         wCzbJMUrSY5W0oxlKuraDNBAdKC/l5GCdg6Ls/nfXBsiQcPzJA872t5cBINaIunUx8hX
         HS9SZezLZny0lCD6l4DYgwz//UZITTRlJFsKe2l9GnroABaoL0n/5oU/r1b5t4CEUQVB
         ayRQ==
X-Gm-Message-State: AOAM533Ya10nTAtEuwXUlSDnXcWp6izZOmqj+8ovlKHQscqY2U3ph1py
        XMT8oYkr6W+XoKWQ1j94v+onrPtSbgV3y+7j9kQ=
X-Google-Smtp-Source: ABdhPJzzkoMmh+8bFo4DFjuS+q83jSIy/kD0c31YD8u1MtLq/IJn2Let+Xu4I61qkFKi1DswDACN2EjSEyxicKnIETg=
X-Received: by 2002:a7b:cb97:0:b0:394:3374:7f93 with SMTP id
 m23-20020a7bcb97000000b0039433747f93mr7348699wmi.204.1653040129400; Fri, 20
 May 2022 02:48:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1788:0:0:0:0 with HTTP; Fri, 20 May 2022 02:48:48
 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <avasmith0002@gmail.com>
Date:   Fri, 20 May 2022 02:48:48 -0700
Message-ID: <CAD6OVVthYeypVUREoeMCVgLkxdjSGtGkpibSingTe9zugdf__A@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [avasmith0002[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [avasmith0002[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
