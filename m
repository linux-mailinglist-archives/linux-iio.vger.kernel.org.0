Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D24A3CCB99
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 01:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhGRXla (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Jul 2021 19:41:30 -0400
Received: from mx.ucr.edu ([138.23.62.67]:2044 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhGRXl2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 19:41:28 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2021 19:41:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1626651510; x=1658187510;
  h=mime-version:from:date:message-id:subject:to;
  bh=eF6Rd98jNhxOdaSdl1REkhQ3PC3sjrP0IS5IWgzrbNw=;
  b=NBXORp6+EwYdTuX/i+pRJJcmY1qHV02ZNUYAoPdXDwiHPsBgp2xGcT8u
   DZCfCC3YX02JAwgv8PP7uD7VCjcqPMfzJqSflW4HFv2fWo4i6agSigby9
   R//UEAQVYZI9LwdVEUdqkNRKw4ThoMyFgxcITa1zDXs2+nfab3+W2rpvT
   oK57QR1dbFXyhrXqPJ0TLTvKkjdnsBphxmQsQZnfMDh+ASac5qdavD++p
   Jzm6EQ/mJUMuaVR/pTd9Upuwow6s5CCw5tOgaaTqWvycWecIQCdCjBrr2
   5Ikm8Ca7nbV78e4bVJtONxo0lLwNEYcR2qO4TefvVdi/Q+Lwm1o4mwvd8
   w==;
IronPort-SDR: sMWpUi+p0m4i0s4oU2z5XfDGK4BISULkWl4P5sIsKEifNtJSyhItZArhPz/gDKogsDr+ODR/2A
 /KwnQYbOcW2iH8CXKqYcGLgOj8ihEG9uWxcqAnZmqb9JrgAmVazjWJONmJMP1EY3FTy8avd8zu
 adUTHsPToVBJ57MjbuJDftOkUmKwbvTvjdWS2MEH8b8sY38cWyzcYWUiRyXdj+GCpVSdGOjcft
 M6vCH0lsWu9EFAYEOnJDxf8VKrRgxYdsmQznAytDs+9Lm/CvY5PEZkCkqYvvdXAgFgOYLAhM7V
 d2qJJ75OYs6bUYE+wkpZVuBq
X-IPAS-Result: =?us-ascii?q?A2F4BgDpuPRgf8fSVdFagQmBWYN4hTSVCAGYOIF8AgkBA?=
 =?us-ascii?q?QEPQQQBAYdXAiU1CA4CBAEBAQEDAgMBAQEBAQEDAQEGAQEBAQEBBQQBAQIQA?=
 =?us-ascii?q?QGBDAtZC2OBT4F5BgQ9gjgpAYQFEQR4AwwCJgIkEgEFASIBNIVXBZoagQQ9i?=
 =?us-ascii?q?zJ/M4EBiA8BCQ2BYxJ+KocKgmiEIYIpgUuCOIhQgmQEgiuBZW6DHgEBAZ8Nn?=
 =?us-ascii?q?QkBBgKDChySP4t6K4Nji16XHZBThTWlIxAjgTkBghMzGiV/BmeBTEwBAgECA?=
 =?us-ascii?q?QwCAQIBAgECAQIIAQECjigWjXABXCRnAgYLAQEDCYxHAQE?=
IronPort-PHdr: A9a23:WSsTuhTnMWVr5PwgiQ1f6I8Oc9psoq2YAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBcOBurkc2qKW6/mmBTVRp87Z8TgrS99lb1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 RmosQndrNcajI9tJqotzhbCv39Ed/hLyW9yKl+fghLx6t2s8JJ/9ihbpu4s+dNHXajmZaozU
 KZWDC4hM2A75c3rsQfMQA6S7XYCUWsYjwRFDRHd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54
 Kh1ThLjlToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+dlc6jDYd0VW3ZOXsdJVyxAHIy8a
 ZcPD/EcNupctoXxukcCoQe7CQSqGejhyCJHhmXu0KI10+ovHwLI0hE+Ed0Sq3nUsMn5Ob0OX
 eyp0KXFzzPOZO5W1zfn74jIdwgsrvONXbNxccrR1E4vHB7GgVWQs4PlPi6e2+MNsmma7+pvT
 +Ovh3I7pwx/uTWv29sjipPTio0L11/E6Dx0zYAoLtK3VEB1e8SrEIdMty6ELYt2RNsvTmBst
 Ssn1LAIt5C1cTUXxZon2RLTduKLfoyV7h/iW+icIzh1iGxkdb6hgxu+7UatxvH+W8e6zVpHo
 DZIn93Cu30Lyhfd6dCHR+Nj8ku93TuDzQPe5+FeLUwqiKbXN4QtzqM0m5cXt0nIAzX4l1/sj
 KCMc0Up4u2o6+P6bbr4vpKcLIp0ih3mMqQph8y/Hfw0MggQUGif/uSxzLjj8lf4QLVOl/E2i
 qfZvI3DKcQVu6K0BwtY3pws6xa4CDem39AYkmcdIF1ZfxKHipDlO1DIIP/mEfeym0qgnCtvy
 vzcPbDsAo/BImbenLv9Z7px9kpRxQ4rwdBa/Z1UC7UBIPzpWk/2sdzVFh84Mg20w+n9CdVxy
 p8SVGyUD6+ELKzSq0WE6fwyLOmRfIMVoiryK+A55/7yin80gVsdfaiv3ZsKZ3G0B/VmI0SeY
 Xf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mXs//QdWPh7qIwCeyGNV9b2VLEFeKW
 SPqdo7eAN8PZTiUL8snlSYLA/zpa4Y7yRSzqEfZzbNuJemcri4evJvo1551z+LWhVc++GowR
 +CUyXrId2xok3lAbDs/wbtypwQpzl6ZyoB9juBRG9tUof9EBENyDZPAwvYyLt3/QB3IetvMc
 0qvTtGrG3llVtc8zsURS154Fti4kVbF0jb8R/cwnqyKAZF82aXFwnX1JsA1n3PN07A8gl0nR
 I1UKWj93IZw8gHSA8jClEDP0+6DcakM1SjB7mrL8W2Us1xVGFp5VajVVHYTfEaQsdPj6V7PZ
 6SyT78gN10FgcqDLLZaL9zoin1YS/r5ftfTeWS8nyG3Hxnb6KmLad/bencdwSKVOkgNkkhH7
 GSGPAlmXnyJvmnESjFiCAS8MAvX7eBipSbjHQcPxAaQYhgkjuLtkiM=
IronPort-HdrOrdr: A9a23:2ps0W6qjgA2c/PQAHmuFUP4aV5oieYIsimQD101hICG9E/bo8P
 xG885rtiMc5AxwZJhCo7G90cu7MBHhHPdOiOF7AV7IZniChILHFvAH0WIg+VDd8u/FnNK1GZ
 0OT0G2MrGfMWRH
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,250,1620716400"; 
   d="scan'208";a="226574504"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2021 16:31:23 -0700
Received: by mail-pf1-f199.google.com with SMTP id x130-20020a627c880000b0290332acd337a6so9663297pfc.23
        for <linux-iio@vger.kernel.org>; Sun, 18 Jul 2021 16:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=K9lKwslw844RDIyYN5dKJv7bJNld7FSUNLoakaytPQ8=;
        b=KpQPqqwLTfXiNjvknkP2ibjsJhXelZqgkRzhfDsK9ivRJlErm1e6ErAZ9PHABWflVl
         kJrw2SDViFhX2ExheVMA+FTJcgPv3POvM97crzTunRTSl+oksdGOZGu6I9U3rQZQhQwm
         jvEyHtfllOMj3b2XV87gr5/q57er1L+sorY6IHHoh9Wj3IhnvmxMv3kbV/chExIrK78C
         w17noNiA34ObetdAybh/6E2piBz1SfyZjgkbNy7T9F2bsFR/rxI0yIz0BX0aLoC2GpPx
         MHIZO+y2emhNzQEWr9I/5MMAz/7V7YSywOO2qBbla1+fNrU5+DCeY2rUIkPEt1jGHAwH
         u5yQ==
X-Gm-Message-State: AOAM533WPp14kMQaGBxNm9ro8gadG2e3sjjno/yZs9GgAtuH9CaCry1R
        9v0jJyU2Gv2S+IMoMAJ+4prr9FfrN9Ro4i8Xx+rYSi2N7gdIQjnWIFo61RuQNQ+YlI/1XZjg6MH
        /1q1kDbB4X+ZMkDqSUIm6ZYN1g7tsMMsAAGVyjQ==
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id w125-20020a62dd830000b02902e8e511c32fmr22628077pff.49.1626651082273;
        Sun, 18 Jul 2021 16:31:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2XjMW3sI3Iy9y+v0EqS4dRn+KBgBk3SB6ID/jsCASxJafnoCwXeJw12ktvR4XWZ+qelO4kpSoMyOYtgezEqs=
X-Received: by 2002:a62:dd83:0:b029:2e8:e511:c32f with SMTP id
 w125-20020a62dd830000b02902e8e511c32fmr22628062pff.49.1626651082069; Sun, 18
 Jul 2021 16:31:22 -0700 (PDT)
MIME-Version: 1.0
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Sun, 18 Jul 2021 16:31:11 -0700
Message-ID: <CABvMjLS8jU2y3owRvsS-PyS5NUyRpQs6Xa_A+U5mfWUTKu3p4A@mail.gmail.com>
Subject: Uninitialized Variable Use in drivers/iio/adc/stm32-dfsdm-adc.c
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All:
Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
could be uninitialized if the regmap_read() fails and returns an error
code.  However, they are directly used in the later context to decide
the control flow, which is potentially unsafe. However,
stm32_dfsdm_irq() returns the type irqreturn_t and I could not return
the error code directly. Could you please advise me here?

The related code:

static irqreturn_t stm32_dfsdm_irq(int irq, void *arg) {
    unsigned int status, int_en;

    regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
    regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);

    if (status & DFSDM_ISR_REOCF_MASK) {}
    if (status & DFSDM_ISR_ROVRF_MASK) {}
}


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
