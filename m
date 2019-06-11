Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC03D25C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbfFKQgt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 12:36:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46663 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404082AbfFKQgs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2019 12:36:48 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so10416693iol.13
        for <linux-iio@vger.kernel.org>; Tue, 11 Jun 2019 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gYzPAXk8a7aoB6vl1u9l/0PecJLMplLKfDe6BKl8FFQ=;
        b=nsF2lxxecbt1rBOEvl9t4dwhKq8fnEb26Z+DOSF9/NCIqGsvclxTPrrincHiUkS9VP
         CZ0FSmrIw56LIJhZBnv6//HGtlblqzrtwnS6M1p3D1+/AHTRjTPLGSJiAgwtw9d6RNeb
         7889+rkRGcf8PuCFO1fDLmp6KfYMXTPeg3ipc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gYzPAXk8a7aoB6vl1u9l/0PecJLMplLKfDe6BKl8FFQ=;
        b=kus3hJwYl9E1x5aUG7Q7vRL0+QSjKcYYSXjYxn2W07oWcR1cwS0YNy61ohii3bw056
         DCwLi5l2krjbJ5K1AA+VzHXKi+vayS7TZxwx8couKHKTPKFr46DQwSXug85j/wrUxQMY
         6ds/9muiQxhNZFbhBRJe7Xk8rXvAN15k8myrnK19u45d3eVnoBeFlXxnrdangVCOuZKK
         llv6BpRgbMme8p/5b16fO8BLG6Tf+Nlyin2ZsncBHG6rJuwPBKuKh0sf73lcZIilFZw2
         3g1xx7nYN9KKUgxxW4+nUnpTNPaUyQ5K3pHN7wPI9YpFBUF1xHEmwHWlUbN99FVl1Yv2
         SlCg==
X-Gm-Message-State: APjAAAX2a1+UxPyx5xgVBflA27+KSR0gLynlc6cJy9GUfGj/c4BXB04s
        e3r/LaLM4HUjpsuTi8c7OIj7tXaUXd1qvgdvLFlL5Q==
X-Google-Smtp-Source: APXvYqx+r2vCjUmZn+ZIJW31AhKGEMOAMbEZ+qDJO8rf2pkN9WLX1veNNRDlk0IFM8tV2lmxivXR1Td/Y8SulWGDvkc=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr35058608ioo.237.1560271008036;
 Tue, 11 Jun 2019 09:36:48 -0700 (PDT)
MIME-Version: 1.0
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 11 Jun 2019 09:36:37 -0700
Message-ID: <CAPUE2us72m0iK5vy=8k81YgwWwM+FpKTZUF00ogMMLWAsh-UTA@mail.gmail.com>
Subject: libiio: support for channels that have no modifier or are not indexed
To:     michael.hennerich@analog.com, ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Michael, Alexandru,

Enrico and I are looking at using libiio to access chromebook sensors
instead of using sysfs iio directly.
Some of our sensors do not have modifier, they are not seen by libiio.
This is an existing open bug:
https://github.com/analogdevicesinc/libiio/issues/25

I am proposing a change to address this at:
https://github.com/analogdevicesinc/libiio/pull/273

It works on chromebooks, but it may fail for other sensors. How can I
test this changes will not introduce regression?

Thank you,
Gwendal.
