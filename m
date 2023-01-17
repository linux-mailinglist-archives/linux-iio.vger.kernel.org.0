Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785666D819
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 09:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjAQIYk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 03:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbjAQIYV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 03:24:21 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A832BECB
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 00:23:55 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id vm8so73504423ejc.2
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 00:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdY7eS2gudaCi6HurWv3eem+oJar6G0+HOwoGQXhZ5k=;
        b=TVue1D0OQ7ueDetwat3HXPXuoLTzL4OavmTfmfTu0EXDGfYNrX8I+fQmNlE0YXrPFu
         JM7mznzDG9iq8uTBbFjjXWvzkcaU+K7lp07RKeM8zVq9Jq05BrppCaNmFutII1Cf3Iqm
         Y35tMnUuhUhqi/66MUCquDagUTem80SyCzo9mL1gFyAHOZ2FOcIcgUZLZf7r4HO1pvH3
         lyNIqFd/0iwR4dcZ27LTD68degQpcHhJzOs1kfgJGGVJ/+doMeExbvZCctc01x9GSfBa
         12c5g25Ne5bQxSnIhdamgGopezoK+YKI9J85xxeSdv7E/sSvUtvBrpuPh98QCv6GYsFE
         vXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdY7eS2gudaCi6HurWv3eem+oJar6G0+HOwoGQXhZ5k=;
        b=w7bPYk+fSYe3v9CW5yAb2BAQoFKjIyZrz2zNQCxPnFjHGjnGVKKIAmcLYvyogXqL1R
         dCkVU+xAqulWhLkAXc+wpd17lWcQl0NcKaCaArbRpxvaDqOyOKwrcY5eMsM6LLPdB0GN
         1WJOCr7kNkYlvggqC+2Omf5K23XyHww6wVC5VZ1wYwErZfFkowa6pySBYJNIqzS+t3Gb
         cSsu0i2d/P4/M6CNBSPYTC5Pf9DVczW2e0R8WnR25G2KHkA4cD/oYaEBEpB2D95jLVzf
         60ZvQ1xW9SYAw0NSbJ0tTWwcseZW0pnHCpejobe116yGAZlq5IXR1v5lvBM+hY/ic9Ci
         64NQ==
X-Gm-Message-State: AFqh2kpZz4QSmLFg7UEiGAWUTirI4okj8aNmyZYmgAFFiK39qT3uquCg
        pKCE0fgR/JWudofkzZEo8Rpa/S4vVXC7pn9cEPE=
X-Google-Smtp-Source: AMrXdXun0AXnrBP8ESLXlwsWfYZ6YoLklo3YTNAXwXEF+fWHK8bKLm5JpcUOHZzojB2UuocNEgkBXi2jqBVBSCuft7s=
X-Received: by 2002:a17:907:7652:b0:7c1:275d:976c with SMTP id
 kj18-20020a170907765200b007c1275d976cmr245951ejc.280.1673943835083; Tue, 17
 Jan 2023 00:23:55 -0800 (PST)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: stedoni744@gmail.com
Received: by 2002:a05:7412:c414:b0:9c:49dc:c9c5 with HTTP; Tue, 17 Jan 2023
 00:23:54 -0800 (PST)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Tue, 17 Jan 2023 00:23:54 -0800
X-Google-Sender-Auth: 3NL2SyYlhMuNOWw4pKjGfMJfX_E
Message-ID: <CAKMRoaMiVqvDuO3i_A84HbKJfXtLWdx+-W0mvU=yAak+w9hTPQ@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MILLION_HUNDRED,MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:641 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9996]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9996]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar2[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [stedoni744[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [stedoni744[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I assume you and your family are in good health.

Sum of $15.5m, (Fifteen Million Five Hundred Thousand Dollars Only)
when the account holder suddenly passed on, he left no beneficiary who
would be entitled to the receipt of this fund. For this reason, I have
found it expedient to transfer this fund to a trustworthy individual
with capacity to act as foreign business partner.

You will take 45% 10% will be shared to Charity in both countries and
45% will be for me.


Mr.Sal Kavar.
