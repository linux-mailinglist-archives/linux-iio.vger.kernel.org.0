Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C75778A1
	for <lists+linux-iio@lfdr.de>; Mon, 18 Jul 2022 00:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiGQWkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jul 2022 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiGQWkg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Jul 2022 18:40:36 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580311174
        for <linux-iio@vger.kernel.org>; Sun, 17 Jul 2022 15:40:34 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e69so18106634ybh.2
        for <linux-iio@vger.kernel.org>; Sun, 17 Jul 2022 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zNhUhmWBJ3lNgzEKeFq7abfcgk0YlUWuk7VNsTnNB5s=;
        b=R+p5S7qsNH55Z7tKmyxRSKbOF4u2eBUYaHekyM4wrwQns+QcEKL89eJhnbyYcQqBbQ
         xSr44xVu/r0GeJdVVYccauTNiX05JEj1+zjlXFL1N2kAGYGw1VXUmPQGkxdK+RJgpSGn
         tRstwJYp0vqiXEtlyBW+PH99H0xWpTg6kf2RD/LS1JECg9yKEQVLh6PsRE5oGZ5Gz85C
         BICWzGcwVkrRr3R6jlvCgKI0vux4euqPrkpZL0hUt/UhZZWNstdw+rJdaU4kQRyu8JUo
         npHtjhFXG0Ic8K3eQtEn8vDOzZzrQWzqAuXuVo1bopQ/22C0FNGU2ATHOyVp0uV7IlVw
         rr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zNhUhmWBJ3lNgzEKeFq7abfcgk0YlUWuk7VNsTnNB5s=;
        b=qQwbpf44HUBqBy4siwehqMSZNqqgKmrAx+FiveOAoshGcFdpy92SgjYkGPj55apQrl
         dTC8mPzKIVK9UMS0kujDgGpCm8UoUpNo59mEFtfbHVVgt30z72epvCVt6x10vDEKwUh7
         xGV/9Qp4sZjc/DHUOBWIiJZ8X//ytulOtC40Yax9x3NP1EvAqs1fN1N9I2E/KPN9VGmR
         P+h0nl+7f+OtC/8dB/5vKWaYVpyJRemsG6cHzp9Fg6EAKaRDcIdV+67fk11gv1jR5fzN
         r7jPx5VZ7MNa+cIQd70Aks+smOtHcyiUN1Tks28Jat14+LA3AIeTHRf6+VPejSYn8Pu/
         uAcA==
X-Gm-Message-State: AJIora+or4oidZhL5ZtyT0+yfRQTpUku4gQe20hRyACjrIemt9zhMh95
        cpsb4iGXRbs4/n+B9f8HxJAoAJR4RwQZqWwFYrg=
X-Google-Smtp-Source: AGRyM1s/ja4ehN36dIJ/aQ7+9zgo7XGezoOiJnmLqONYUuEEg1rZ7c2nFNQulCM05mj5hYg9MGeeR9EuZdW3+8Nemxw=
X-Received: by 2002:a25:3807:0:b0:66e:c7d0:e7a7 with SMTP id
 f7-20020a253807000000b0066ec7d0e7a7mr23462147yba.103.1658097633756; Sun, 17
 Jul 2022 15:40:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:57ce:b0:2da:17d8:d624 with HTTP; Sun, 17 Jul 2022
 15:40:33 -0700 (PDT)
Reply-To: amaaofosu001@gmail.com
From:   "Mr. Amaa Ofosu" <amaaoofosuu.box@gmail.com>
Date:   Sun, 17 Jul 2022 23:40:33 +0100
Message-ID: <CAG_aRH8sVQB9BfJUcPwdSm7xh0oN_U9Eh=CQbBJctT1-34FRuA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Greetings,

How are you doing? I got your contact in my search for a trustworthy
and reliable partner for a business proposal. I contacted you so that
we can work together.

Please if my business proposal offends your moral values do accept my
apology, get back to me for more details.

Waiting for your Response.
Regards.
Mr. Amaa Ofosu
