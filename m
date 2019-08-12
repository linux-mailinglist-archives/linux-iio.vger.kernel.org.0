Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8489ED6
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 14:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHLMxG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 08:53:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38007 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfHLMxG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 08:53:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so7610321wmm.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Aug 2019 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SRmZunLU1SEwx7fCTVjayeRQoDGBMc9e5RBc+lZ6+c=;
        b=YSIuyl5b4rh/G0RhpCVRL1mO8OWofj7c7JvgJ51OdOX88ua7Uald/a2mQENIlOIevG
         /JCzDvpLzxIzLS/PCqG1wuKcZyAYSMGZunER4qotGyRnNNVseYe6G3N6J1n8BLTkYbBl
         k/HPySYv7WzLxPkqPk+RPr9a2w12oczUbwO10EoUOruFs4eWOSAg59e9SHS2xKoLd3Ou
         fVtpD5WegeA0lFZZw9Kqn1YmKqeWnBlOdA0PlOxJnfXLkMg8YnLEXyOPQ4K4y2yw++R/
         CzsGZkY8KV/tC/1somD3s3LiXmgbsnwDKu62BuE966JfC83++VG1kyblqKL4k5W6b+3j
         mfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SRmZunLU1SEwx7fCTVjayeRQoDGBMc9e5RBc+lZ6+c=;
        b=jkKMji6gf+6ZxM/u6TF5B4ved0McPjIdDzVZ8WqtdCziXrSFDe3kwsffBKWTTq5n8f
         yAlgkzrc1NTtWwZws75bb+055GkTcLUy1zWsoJg5yQxTsVWi+HuRoG68T6g5kMPuFI0Q
         So5LEo44XBvbmlC683q+PFnFSwVD8TuF5hYxlnQ3zmFAlR0LJbv7vdMmuwl4WTMGu+xf
         ZcfUDxBHl3FzO+HiPu6KSauwYabusxAQasTORcUud68G9D4tytfz/DN5Mvg5wmGJyojo
         5PaDtMdaoXM7o3+LOTrxJ5ZEX6/lyewBLQvUGt+V8/jnfsJTb+2Tz6BRyRdp3n/DwkpM
         STkA==
X-Gm-Message-State: APjAAAX3Zy/XzIg9KLDo9kmVpEbzSruBFrbGI0AXCCnkpgLhpLfXJsb/
        M4uaSqCETici55NgqaIK8VRJlw==
X-Google-Smtp-Source: APXvYqxfut80XUPsGlKL7HH2DypzP8QuO9nbY89KSfg+DYzMo+WkOgviCMx6XofhBIFjgEigvsiSxg==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr27652159wmi.91.1565614383331;
        Mon, 12 Aug 2019 05:53:03 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r16sm28288431wrc.81.2019.08.12.05.53.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:53:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] irq/irq_sim: make the irq_sim structure opaque
Date:   Mon, 12 Aug 2019 14:52:55 +0200
Message-Id: <20190812125256.9690-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812125256.9690-1-brgl@bgdev.pl>
References: <20190812125256.9690-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no good reason to export the interrupt simulator structure to
users and have them provide memory for it. Let's make all the related
data structures opaque and convert both users. This way we have a lot
less APIs exposed in the header.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-mockup.c          | 12 ++---
 drivers/iio/dummy/iio_dummy_evgen.c | 18 +++----
 include/linux/irq_sim.h             | 24 ++-------
 kernel/irq/irq_sim.c                | 83 ++++++++++++++++++-----------
 4 files changed, 70 insertions(+), 67 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index f1a9c0544e3f..9b28ffec5826 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -53,7 +53,7 @@ struct gpio_mockup_line_status {
 struct gpio_mockup_chip {
 	struct gpio_chip gc;
 	struct gpio_mockup_line_status *lines;
-	struct irq_sim irqsim;
+	struct irq_sim *irqsim;
 	struct dentry *dbg_dir;
 	struct mutex lock;
 };
@@ -186,7 +186,7 @@ static int gpio_mockup_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_mockup_chip *chip = gpiochip_get_data(gc);
 
-	return irq_sim_irqnum(&chip->irqsim, offset);
+	return irq_sim_irqnum(chip->irqsim, offset);
 }
 
 static void gpio_mockup_free(struct gpio_chip *gc, unsigned int offset)
@@ -247,7 +247,7 @@ static ssize_t gpio_mockup_debugfs_write(struct file *file,
 	chip = priv->chip;
 	gc = &chip->gc;
 	desc = &gc->gpiodev->descs[priv->offset];
-	sim = &chip->irqsim;
+	sim = chip->irqsim;
 
 	mutex_lock(&chip->lock);
 
@@ -431,9 +431,9 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 			return rv;
 	}
 
-	rv = devm_irq_sim_init(dev, &chip->irqsim, gc->ngpio);
-	if (rv < 0)
-		return rv;
+	chip->irqsim = devm_irq_sim_new(dev, gc->ngpio);
+	if (IS_ERR(chip->irqsim))
+		return PTR_ERR(chip->irqsim);
 
 	rv = devm_gpiochip_add_data(dev, &chip->gc, chip);
 	if (rv)
diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index a6edf30567aa..efbcd4a5609e 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -37,7 +37,7 @@ struct iio_dummy_eventgen {
 	struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
 	struct mutex lock;
 	bool inuse[IIO_EVENTGEN_NO];
-	struct irq_sim irq_sim;
+	struct irq_sim *irq_sim;
 	int base;
 };
 
@@ -46,19 +46,17 @@ static struct iio_dummy_eventgen *iio_evgen;
 
 static int iio_dummy_evgen_create(void)
 {
-	int ret;
-
 	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
 	if (!iio_evgen)
 		return -ENOMEM;
 
-	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
-	if (ret < 0) {
+	iio_evgen->irq_sim = irq_sim_new(IIO_EVENTGEN_NO);
+	if (IS_ERR(iio_evgen->irq_sim)) {
 		kfree(iio_evgen);
-		return ret;
+		return PTR_ERR(iio_evgen->irq_sim);
 	}
 
-	iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
+	iio_evgen->base = irq_sim_irqnum(iio_evgen->irq_sim, 0);
 	mutex_init(&iio_evgen->lock);
 
 	return 0;
@@ -80,7 +78,7 @@ int iio_dummy_evgen_get_irq(void)
 	mutex_lock(&iio_evgen->lock);
 	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
 		if (!iio_evgen->inuse[i]) {
-			ret = irq_sim_irqnum(&iio_evgen->irq_sim, i);
+			ret = irq_sim_irqnum(iio_evgen->irq_sim, i);
 			iio_evgen->inuse[i] = true;
 			break;
 		}
@@ -115,7 +113,7 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
 
 static void iio_dummy_evgen_free(void)
 {
-	irq_sim_fini(&iio_evgen->irq_sim);
+	irq_sim_free(iio_evgen->irq_sim);
 	kfree(iio_evgen);
 }
 
@@ -140,7 +138,7 @@ static ssize_t iio_evgen_poke(struct device *dev,
 	iio_evgen->regs[this_attr->address].reg_id   = this_attr->address;
 	iio_evgen->regs[this_attr->address].reg_data = event;
 
-	irq_sim_fire(&iio_evgen->irq_sim, this_attr->address);
+	irq_sim_fire(iio_evgen->irq_sim, this_attr->address);
 
 	return len;
 }
diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index 4500d453a63e..4bbf036145e2 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -14,27 +14,11 @@
  * requested like normal irqs and enqueued from process context.
  */
 
-struct irq_sim_work_ctx {
-	struct irq_work		work;
-	unsigned long		*pending;
-};
+struct irq_sim;
 
-struct irq_sim_irq_ctx {
-	int			irqnum;
-	bool			enabled;
-};
-
-struct irq_sim {
-	struct irq_sim_work_ctx	work_ctx;
-	int			irq_base;
-	unsigned int		irq_count;
-	struct irq_sim_irq_ctx	*irqs;
-};
-
-int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
-int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
-		      unsigned int num_irqs);
-void irq_sim_fini(struct irq_sim *sim);
+struct irq_sim *irq_sim_new(unsigned int num_irqs);
+struct irq_sim *devm_irq_sim_new(struct device *dev, unsigned int num_irqs);
+void irq_sim_free(struct irq_sim *sim);
 void irq_sim_fire(struct irq_sim *sim, unsigned int offset);
 int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset);
 
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index b992f88c5613..79f0a6494b6c 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -7,6 +7,23 @@
 #include <linux/irq_sim.h>
 #include <linux/irq.h>
 
+struct irq_sim_work_ctx {
+	struct irq_work		work;
+	unsigned long		*pending;
+};
+
+struct irq_sim_irq_ctx {
+	int			irqnum;
+	bool			enabled;
+};
+
+struct irq_sim {
+	struct irq_sim_work_ctx	work_ctx;
+	int			irq_base;
+	unsigned int		irq_count;
+	struct irq_sim_irq_ctx	*irqs;
+};
+
 struct irq_sim_devres {
 	struct irq_sim		*sim;
 };
@@ -63,34 +80,42 @@ static void irq_sim_handle_irq(struct irq_work *work)
 }
 
 /**
- * irq_sim_init - Initialize the interrupt simulator: allocate a range of
- *                dummy interrupts.
+ * irq_sim_new - Create a new interrupt simulator: allocate a range of
+ *               dummy interrupts.
  *
- * @sim:        The interrupt simulator object to initialize.
  * @num_irqs:   Number of interrupts to allocate
  *
- * On success: return the base of the allocated interrupt range.
- * On failure: a negative errno.
+ * On success: return the new irq_sim object.
+ * On failure: a negative errno wrapped with ERR_PTR().
  */
-int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
+struct irq_sim *irq_sim_new(unsigned int num_irqs)
 {
+	struct irq_sim *sim;
 	int i;
 
+	sim = kmalloc(sizeof(*sim), GFP_KERNEL);
+	if (!sim)
+		return ERR_PTR(-ENOMEM);
+
 	sim->irqs = kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP_KERNEL);
-	if (!sim->irqs)
-		return -ENOMEM;
+	if (!sim->irqs) {
+		kfree(sim);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	sim->irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
 	if (sim->irq_base < 0) {
 		kfree(sim->irqs);
-		return sim->irq_base;
+		kfree(sim);
+		return ERR_PTR(sim->irq_base);
 	}
 
 	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
 	if (!sim->work_ctx.pending) {
 		kfree(sim->irqs);
+		kfree(sim);
 		irq_free_descs(sim->irq_base, num_irqs);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	for (i = 0; i < num_irqs; i++) {
@@ -106,64 +131,60 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
 	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
 	sim->irq_count = num_irqs;
 
-	return sim->irq_base;
+	return sim;
 }
-EXPORT_SYMBOL_GPL(irq_sim_init);
+EXPORT_SYMBOL_GPL(irq_sim_new);
 
 /**
- * irq_sim_fini - Deinitialize the interrupt simulator: free the interrupt
+ * irq_sim_free - Deinitialize the interrupt simulator: free the interrupt
  *                descriptors and allocated memory.
  *
  * @sim:        The interrupt simulator to tear down.
  */
-void irq_sim_fini(struct irq_sim *sim)
+void irq_sim_free(struct irq_sim *sim)
 {
 	irq_work_sync(&sim->work_ctx.work);
 	bitmap_free(sim->work_ctx.pending);
 	irq_free_descs(sim->irq_base, sim->irq_count);
 	kfree(sim->irqs);
+	kfree(sim);
 }
-EXPORT_SYMBOL_GPL(irq_sim_fini);
+EXPORT_SYMBOL_GPL(irq_sim_free);
 
 static void devm_irq_sim_release(struct device *dev, void *res)
 {
 	struct irq_sim_devres *this = res;
 
-	irq_sim_fini(this->sim);
+	irq_sim_free(this->sim);
 }
 
 /**
- * irq_sim_init - Initialize the interrupt simulator for a managed device.
+ * devm_irq_sim_new - Create a new interrupt simulator for a managed device.
  *
  * @dev:        Device to initialize the simulator object for.
- * @sim:        The interrupt simulator object to initialize.
  * @num_irqs:   Number of interrupts to allocate
  *
- * On success: return the base of the allocated interrupt range.
- * On failure: a negative errno.
+ * On success: return a new irq_sim object.
+ * On failure: a negative errno wrapped with ERR_PTR().
  */
-int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
-		      unsigned int num_irqs)
+struct irq_sim *devm_irq_sim_new(struct device *dev, unsigned int num_irqs)
 {
 	struct irq_sim_devres *dr;
-	int rv;
 
 	dr = devres_alloc(devm_irq_sim_release, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	rv = irq_sim_init(sim, num_irqs);
-	if (rv < 0) {
+	dr->sim = irq_sim_new(num_irqs);
+	if (IS_ERR(dr->sim)) {
 		devres_free(dr);
-		return rv;
+		return dr->sim;
 	}
 
-	dr->sim = sim;
 	devres_add(dev, dr);
-
-	return rv;
+	return dr->sim;
 }
-EXPORT_SYMBOL_GPL(devm_irq_sim_init);
+EXPORT_SYMBOL_GPL(devm_irq_sim_new);
 
 /**
  * irq_sim_fire - Enqueue an interrupt.
-- 
2.21.0

