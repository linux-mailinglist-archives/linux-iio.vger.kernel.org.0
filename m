Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B474DC27D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Mar 2022 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiCQJTj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 17 Mar 2022 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiCQJTi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2022 05:19:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF011C2A
        for <linux-iio@vger.kernel.org>; Thu, 17 Mar 2022 02:18:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so9341931ejd.5
        for <linux-iio@vger.kernel.org>; Thu, 17 Mar 2022 02:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=miLrs4KVx0dq1vaAvsX+xq8qvhSQ5tEKVxnd0d1EeYs=;
        b=IZeqafUgLWMH1mI/98r4c+84SML1g+sOmk0NwZgAwISqjq98FaZS4EwWew9mQplCtD
         YPSKoc1Pyya90ZKfmPKXpNdUk8lhIiJ8yaLKdOfCwjsHQSWcDeqWAyOSQ3/iffTtll+L
         rjoP0nYsJqRcEuSsiByZTU4obnzbLx4Q7MtOaD/Yw0eLWD2f+CmPcPjxbQO/u3g8bxhf
         ypMIRAzNOIo/bm6o/hEH00h+xSAkQ0k+6NYEDRFObhsICWLKquOzn3vGA6/KxcyMsyJk
         jKUTYCrGQbqTEJiTVPwcY10lGsy4KexqNAqPOmJ9FtyHnyIdU6WolRpS4zq8cNBHF7PO
         1NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=miLrs4KVx0dq1vaAvsX+xq8qvhSQ5tEKVxnd0d1EeYs=;
        b=nAd3RHy2LVGqWknt/HlwQhBKJofSeDzXhXebfBwwTOQYyM4VTBtWdlh+NYxtx0Nowq
         lgGTie3WL9TH1J92JEhHRtjV1reOORDzWLYkvtb21Q75StCURd6gvSarCAiOe0QMIq6C
         XuQkpNSZTs4l8fMym6XCn10PcdChDk+Tcgn6d/3KFs3g9xe89Cuo9F1QKThNCF4mAMMV
         UHrS1ndj3DfzgBQlcuUVbXHSzEh1ncnPqSEcISNlZ1fVKnNrvLPVDSgHptbr4BJ1Uby3
         Pzl1y2xLCVuUI9+r7z4ykis/9M9HsJTMw6bmHzeXAui+cVGbOBooQr1JaVRY52NQdUSb
         IXsg==
X-Gm-Message-State: AOAM533Fynrg2m41iFBpf3OxkBLS5PxiMeMZsUZlf4vPly5uaQK7T+sY
        e72i94joxJtPv8ee2iDUXBAbVScAPJqVSgbFOwB8wJBlMd6dNQ==
X-Google-Smtp-Source: ABdhPJyPiCsO7EnxTb/xL+7+QMhwSkyW0g0s4jOjdCkKoBxJjdG+esMYpLZkPrUUaVlG+aZqhsHSSfP/PSdu4rkn7WM=
X-Received: by 2002:a17:906:6a2a:b0:6cf:d228:790c with SMTP id
 qw42-20020a1709066a2a00b006cfd228790cmr3499392ejc.75.1647508701196; Thu, 17
 Mar 2022 02:18:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a55:80df:0:b0:14c:2857:9284 with HTTP; Thu, 17 Mar 2022
 02:18:20 -0700 (PDT)
Reply-To: fbenson033@gmail.com
From:   fred <lindabensonabc@gmail.com>
Date:   Thu, 17 Mar 2022 10:18:20 +0100
Message-ID: <CACR67cc-Byvn75xhWb3Kb_uqO6C+NL_rO-D-XQ103RW=eSpXpQ@mail.gmail.com>
Subject: i am sick
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_USD,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62f listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0872]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lindabensonabc[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [fbenson033[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello
  i am Fred Benson from the United Staes of America.i need your help
and support in the transfer of 4.5 million united states dollars into
your bank account abroad..
please get back to me for more details to proced.

Regards
