Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946EB72A72C
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jun 2023 02:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjFJA62 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jun 2023 20:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjFJA61 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Jun 2023 20:58:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7826AD
        for <linux-iio@vger.kernel.org>; Fri,  9 Jun 2023 17:58:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 41be03b00d2f7-53482b44007so991428a12.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Jun 2023 17:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686358706; x=1688950706;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SOQvEYFJS49CmVb219guKJhS/TAPg15aR5EB78g0vGA=;
        b=JeS8wxLCvHAWZUidwa1TDbmldfslEpMI/X5u1/PqQZ+g9KaM4OgIfvivRHE6uSlqZm
         cSUpXQhkSG6HEw5JH9fjk+0zByurF+SzYxQILW+ifQdhGb3rbhGxbxCCWeXDa72ikjUi
         CgrbEV5HmEnj1+aEchT94L6EZYDy2pUduRmXrm2XD8fmh2CHtn0gUpQTGtSMSf0GFP2O
         cNps5YwYEzskkn2oPjeWXGYrQLkoKBmuCsqw6BOs1igLQNE6z4aJINskBiSiX7ByUVZD
         MPqT8JwEHIoBWglZ/Ve4nfrXc65nlHGElGj7KZT0sBsDhCZs3OLqgZwI4euN+9kw73Zi
         NBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358706; x=1688950706;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOQvEYFJS49CmVb219guKJhS/TAPg15aR5EB78g0vGA=;
        b=lnAkvYLJ4L/8ytTCNV51GUl31ddULLC+hOR57Fgmolb/0Kc6awTUTPFrQJMlNEOOM2
         oN6MXvO5yBNA5l7eEKnrRHGBdpHE0nxN5nLQ80gQk79El5GyJHjIILvK5JhKszCfOIp6
         jkyLajb7UIQGtF1NTtL90WDQXlxJFM/6HkPdOyo+O1ut5YnC4zIYZBCYH6fnM76E6ocG
         3HN5aCFDOC7IwplwtvFi8ipxpEDieUd+a8rM9mecLwilHO0+1Kv7ddwZBdleJ5wAKkPH
         dcBfcEu3VutM8hpTy1tPMivYpnIoUxfnFRIvgMDebFgjVAGRb7c25uSr/gw+7LE3C3dz
         NUGw==
X-Gm-Message-State: AC+VfDzAjmmWP5LPC2ClyKaDBcV4ID5qzMbgafN3e5GpCdUaTNCZgCPc
        TAqaKK4GHagiTf5xbAcYYnlsZ04Q9doloRZcquk=
X-Google-Smtp-Source: ACHHUZ6aU4mB1SL49AlKAV0uOr1wap/vDC+m3rzGCLaVqo2isTcPhRVc+DvK9F0tGBUR6GV04eYS/EC3gSiFogmF12s=
X-Received: by 2002:a17:90b:f8e:b0:256:1fd3:b593 with SMTP id
 ft14-20020a17090b0f8e00b002561fd3b593mr2295470pjb.38.1686358705815; Fri, 09
 Jun 2023 17:58:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:a687:b0:47b:6481:cb77 with HTTP; Fri, 9 Jun 2023
 17:58:25 -0700 (PDT)
Reply-To: mauhin52@gmail.com
From:   "Mrs. Maureen Hinckley" <zaraumnjidda@gmail.com>
Date:   Sat, 10 Jun 2023 01:58:25 +0100
Message-ID: <CAP6gr-cggQ2N1M5xoF4YwFh8CTeZjJFu+CdfrN0PN-LVA+fuWw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5093]
        *  1.0 REPTO_419_FRAUD_GM Reply-To is known advance fee fraud
        *      collector mailbox
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zaraumnjidda[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mauhin52[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--=20
Hello,

I am Maureen Hinckley and my foundation is donating ($550,000 USD) to
you. Contact us via my email at (mauhin52@gmail.com) for further
details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92023 The Maureen Hinckley Foundation All Rights Reserved.
