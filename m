Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD165EDFED
	for <lists+linux-iio@lfdr.de>; Wed, 28 Sep 2022 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiI1PQJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Sep 2022 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiI1PQI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Sep 2022 11:16:08 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0563648EA2
        for <linux-iio@vger.kernel.org>; Wed, 28 Sep 2022 08:16:04 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3539c6f39d7so16000817b3.12
        for <linux-iio@vger.kernel.org>; Wed, 28 Sep 2022 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=K9aCivmd3pOhXO+7wSe24RMSLcWBP61HE/hhO1yg1yw=;
        b=jQDRdbrOzvtuDZp8qb7JAXZre+A6bwoDBFWrmE3ggrcRhbpYUYGIBaVIaiwSSXReqv
         NSqmEfYF+qoN2fvrTr0/Kdirbrpg4+UYSv65VbWz4ow0+IxHc/H7ImJT7gEjY46SBxZP
         7Il+Y8xwtxZg5pP00iGG/49S7gXAVB7KUDPIEoF0X/qO0b9fbkC4VnomI48ETNTZG1hM
         ceyhVPq0CZ6FaLIojWQKcd86FNA9HXS8YFKU1ntXLpDM8om4eDpcwOoL2sNujwTT7t5c
         Y4jrN5q14BF20MbATCfK8ZeItCNebtAvYE0mwaRddKDOOyTit5O/0TzPc+zeaMy/DTUw
         jTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K9aCivmd3pOhXO+7wSe24RMSLcWBP61HE/hhO1yg1yw=;
        b=FapzNglBoK89jVFle55xonKnHfUTnkkFwxbxoWz6ydRTDlkHkOjkFdhSJ4m0EmaTIr
         sJbFuObio7zXIBMRwneYSh4T+YPVuxw5eWcGQY/IfrglYTNjKcUdu6xqUp3/1dGmucLh
         4/5XFo5QtS3it0alY/UD6M8pweO1itw+UJiAMNsQY6uTYV1XNpnxkc2mJE2F8bCe4UmZ
         K0PwCmUv/41ivnUXz+GjPAT7mg7EUk7sbPzbmz7JUeUzSXNM6yMjVFHlRYH+4LoDTeXk
         nvBjXRvAG4ISKnLS27CffOO3YXkyZBQZ1wu862NXfPkdaX0U5oVgKqKEtyj+asZ476MZ
         JmQg==
X-Gm-Message-State: ACrzQf0LRAjWLtkeSVS00S5oNYF6RuWjtMiN1uJeS1x+WypeEX8+r8m9
        YI15RakreoJsfComMps/UT/GaD3z8txdPbYBIh4=
X-Google-Smtp-Source: AMsMyM7HSO0jCM6RgMdFO9ayMXe5OewG2dGbzmnUvBuF/uH00UHhOBxamsZdaE5YX5EYJO+HovNw82I+L57Un5YJHb8=
X-Received: by 2002:a81:74d5:0:b0:345:27e3:bc6e with SMTP id
 p204-20020a8174d5000000b0034527e3bc6emr30678192ywc.394.1664378163024; Wed, 28
 Sep 2022 08:16:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:248c:b0:305:91e8:4ae7 with HTTP; Wed, 28 Sep 2022
 08:16:02 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidkekeli442@gmail.com>
Date:   Wed, 28 Sep 2022 15:16:02 +0000
Message-ID: <CABGDXtqMoKAA0=GZYYzGTDE4A4awYvWrZnLwX4yD1A7BRnnOQg@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4989]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidkekeli442[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidkekeli442[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Best Regard,Mr.Abraham,
