Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CEA6C381B
	for <lists+linux-iio@lfdr.de>; Tue, 21 Mar 2023 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCURXm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Mar 2023 13:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCURXl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2023 13:23:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE44129E0B
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2023 10:23:40 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5419d4c340aso292588337b3.11
        for <linux-iio@vger.kernel.org>; Tue, 21 Mar 2023 10:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679419420;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=XDQ9LlEhzIi5+n6KgIeotLr5u8jTCmd60LrHCStSMqEKf/zft/FrCIVMlYjtcBC5aX
         u6B09oBd9psyJcSHBTcXVEM/I2pu3IsNpyG1OWPbmtaGa3bvAlC4WeAZSbaVWLj/+HMa
         RKfsQRXu1nzMJ6gARThhG8+AzkZxa4/LBJThcoEI0RIS4ZsWl/WfH04lTBGXcNG4xl7j
         Oc+VbX1eZZatG0TsMMO9QQPWKFO99igT0tvChMYznPcxqngTOYtAGMC4SndP1P1otwes
         lvXp9q+Paz0ULcK9zDOqVvD0uyIk7p7FBfyIa5A3azxtuYtVi+RiF/FJOF7Oys76PnxA
         rW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419420;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=HWl9Qd8hFZSMAYJNyAlqFHXR3H6k1eplXFh6odvVjxbLQVI8KSCeX9dXabsVt/HyRe
         WMGx0nHvfcfxxLkP1mZ13hTBOZkoHjHq88JnY4vhb3kTi/9JSmQk6Z7IprBfYrZqn6r+
         Uv8p/43p9vtRzW1A4NsumSKLi+KNrs2TddFgkM9HHcz2iIn0zF55XZdffFyLnEZIrm76
         5l65qTBm1QE2dH0Eq+EIQxpddOIXpEo86fYzLj9gqdh7ozMJzftEckxd3cGWMLAoiaiu
         cjgDlLimgmYnvWGtIjqFfpqAHkZyjD16HnMdDeihiikc4Lp+zPil7kQ0cRuNFIxtVsxK
         ZYuA==
X-Gm-Message-State: AAQBX9eypUDmJA+rB7/FAj1vO6nIOAvlVYqbgu7i5/FTtPmjq3v35Ave
        KaFOWfcUFzOOeI7DojHIgWCOprX4wsFiCkXWI4k=
X-Google-Smtp-Source: AKy350YoW3+Cpvki6lJi3kJcdSpPVMDpaJ4M9d1CHsZE20nQ5LW8op7T4H2+ARZnHBXIV/Ba1LEA5IOcmIA6iASHHMA=
X-Received: by 2002:a81:4305:0:b0:52e:e095:d840 with SMTP id
 q5-20020a814305000000b0052ee095d840mr1518924ywa.0.1679419419685; Tue, 21 Mar
 2023 10:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:12c7:b0:340:8f83:4d75 with HTTP; Tue, 21 Mar 2023
 10:23:39 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gracebanneth@gmail.com>
Date:   Tue, 21 Mar 2023 10:23:39 -0700
Message-ID: <CABo=7A0__p4v788YLj95WdsH0iByDKNgAVn-r6HpsvKuyZcL9g@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5023]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gracebanneth[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
