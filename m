Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0704BB7E6
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbiBRLQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 06:16:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiBRLQa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 06:16:30 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0ED23BF35
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 03:16:14 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id y20so7115521iod.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 03:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=Pan6CQ5hu2zUWWGu7Uie4NrQKmsGKL/CxMvpZg3arHLwqybzfW5vPwI0oNIlnVTVCY
         4c8HMuG3hOlZ2dJ19IADvg7r/uWRLoGCJQRLhgXrRFBRd8cLzV+L8Ry4zDWV8DeUZRYC
         gr9b2V+5LPdM2syWTpwKBi7HAZWKHBCcCiyX+x/fdDeLs666uNWUruqhzwDOsideezPk
         7V2QvzuUtibuz8O4V++lY+8wUh5ErnXfvJD9Z8NYbtVyMRCIcc6LU/EbQRA1jTha3uEl
         TB9ODkMhs1755JcB/E+vFGz8PGcjD5GVLug+doOg+GgTZ0WX/8d+d2eusHRLFm6YvprH
         vbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=VjYCfJ2PaV9FnfNAcLdF/AblKO3oz8f/YXMCtdl7BSx9GufbJmxizLPUekQNd7tToP
         Eout8BEiMbQakIDXT2H7Tjd6FHlNqphryxeriA6HTAFLXHLyT/TVsq+RSTxachUDTrH6
         BtGy6fL/pi+YDhUrNY7+k1VSqep+5/oj7q+uiXTx+JsasvL5wurIbMJR2i7xVSR5jUMi
         xka/uwatsorrVXUkWFlw3ZA2maFsn81rmGsSUnIOFPestrVCn6C7uABfnb2dJ1fcRx0X
         tDnyHIGxbXvRxVCg89I4HhfXu1zBpmgcPiiI+uJ5NkJyJ1HPldief2lmVabWyY9+qB1N
         1oOA==
X-Gm-Message-State: AOAM530Egll/yEYz9nWYyDrLeYjjL8DPWuKfAmpMOC7lfTcQO3oh7/cE
        fkGZF2OK24mE7ZkVLscuLY6nZRXgEQVan6aEQg==
X-Google-Smtp-Source: ABdhPJyYJX7MA4BjA31I/F0RfVIRMUutodreFGyEGO8BeEyItxwVKLbClz1ulV0gK9BDYhDuxAplopBsC5LbHDgKhP8=
X-Received: by 2002:a6b:8f83:0:b0:613:8b75:b76d with SMTP id
 r125-20020a6b8f83000000b006138b75b76dmr5245691iod.77.1645182973880; Fri, 18
 Feb 2022 03:16:13 -0800 (PST)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: ali.wa1234ara@gmail.com
Received: by 2002:a05:6638:3013:0:0:0:0 with HTTP; Fri, 18 Feb 2022 03:16:13
 -0800 (PST)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Fri, 18 Feb 2022 11:16:13 +0000
X-Google-Sender-Auth: ossTFlO9wpy3KD-k9TK98D_rNgI
Message-ID: <CA+0F4TE-LpATnJ0TyO4Reo6H9EQUjwSQquiHVa_gGjzzsAAnFw@mail.gmail.com>
Subject: Greetings to you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
