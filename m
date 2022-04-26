Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B6250FE5D
	for <lists+linux-iio@lfdr.de>; Tue, 26 Apr 2022 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350654AbiDZNMA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Apr 2022 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349818AbiDZNL6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 09:11:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27C51317
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 06:08:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 16so6745324lju.13
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=nIgHZXIaeZhf23re2WIWSl8FwNzY4XssmB5G+OP1fgY=;
        b=Rp5M6DGffMumgwzkfOxSGjjr4ftDhLODR5a1+q5sbrDoKirJOLXuBQ71oayOURisMO
         9Molv9WeL2gfac8WqaGpduQH6/7pR2Awbo44GWSqvV/tk4K9F8weG4VpvHx3pAej7BNF
         HPsLeLucDBWWTffw5HaUQ6d+hbLv1YrsXfNgFQjlReZshnJhK+b55jz4gAES9FItZNOi
         ymE+uxRgs1h7TzFLT3kZQoLIR5mQQlJk9p5lSj+3Yfbs/exThc/f68iWae4fMOA+yfl3
         zGmd3Lvb8K9xbkqQ9nEiwqb4AGeMmEHL8FjHscFDPpE4nQwcz4BC7KcbbB39dik+ISmK
         4QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=nIgHZXIaeZhf23re2WIWSl8FwNzY4XssmB5G+OP1fgY=;
        b=yAZbs3h2OEfwruiGSxV8VVJPZW7/Fi1FsZ450/i9SPYWPdVhVyT0TcdOtgvk3beX1Z
         TgGl6U0J5E3+s6l8Qj7BwDiJk7zOfleXnTulqw/Vu07aUKuUxUjISJjjFbXdOiT1OQx9
         dmMnxGvo7ycz5gGxzpTDmAAL2CloDnszSPe9C9J0gpmmpDtX5SrhHhqArQyy1dGVcA5k
         rrLTHfbQK8vGVzW4uivko7/ri4B95CpClCTKRFMFN+kZuETdEeE5B8KA/kPzi+LX6FRk
         X0xyk5OQQ0xk7c64MXUVBnrABe3PDQ1EnPrhrq+MusHlMicaLbOoEmOWqkvR+xOdVYLb
         0D9Q==
X-Gm-Message-State: AOAM533FU4rVdbQcBmW/cbGd2UYJCI/wV6vax+R8g2Moywv4vsREKm5K
        fhMhfogbt1jpf48iLMBiHJpjdOCtNm21/EBmC9I=
X-Google-Smtp-Source: ABdhPJxJgeVKOFA/6frHypReElNZg7XGWMv45cKJWIMCxQMjsLYM6e2ktns33x2pek7Zln0pYRmYoOJAo4wHgFeZBcM=
X-Received: by 2002:a2e:9c43:0:b0:24b:469:2bb6 with SMTP id
 t3-20020a2e9c43000000b0024b04692bb6mr15136354ljj.248.1650978528342; Tue, 26
 Apr 2022 06:08:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aa6:cb41:0:b0:1be:7e9f:f9a6 with HTTP; Tue, 26 Apr 2022
 06:08:47 -0700 (PDT)
Reply-To: usarmy.jameston1@gmail.com
From:   Major James Walton <josephinmnyinge70@gmail.com>
Date:   Tue, 26 Apr 2022 14:08:47 +0100
Message-ID: <CAEH2Oon1-iK2-v5D9jvDrtSNmU1_Pm6ePrZ8FNs74Jpb3_goVA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4070]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [josephinmnyinge70[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [usarmy.jameston1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [josephinmnyinge70[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-- 
I am Major James Walton,currently serving with the 3rd Brigade Support
Battalion in Iraq.I have a proposal for you. Kindly reply for
details.Reply to: usarmy.jameston1@gmail.com


Regards,
Major James Walton.
